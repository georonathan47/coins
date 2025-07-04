import 'dart:convert';
import 'dart:io' as io;
import 'package:get/get_connect.dart';

import '../../../../core/auth/data/datasources/auth_remote_database.dart';
import '../../../../core/constants/env.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/kyc_entity.dart';
import '../../domain/entities/kyc_status.enum.dart';

abstract class KycRemoteDatabase {
  Future<KycStatus> checkStatus(Map tokens);
  Future<String> initiateKyc(KycModel request, Map tokens);
}

class KycRemoteDatabaseImpl implements KycRemoteDatabase {
  final GetHttpClient client;
  final AuthRemoteDatabase authRemoteDatabase;

  KycRemoteDatabaseImpl({
    required this.client,
    required this.authRemoteDatabase,
  });

  @override
  Future<KycStatus> checkStatus(Map tokens) async {
    try {
      final result = await client.get(
        '${Env.checkStatusUrl}=${tokens['userId']}',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      TLoggerHelper.logApiResult(
        httpMethod: 'GET',
        method: 'fetchKycData',
        code: result.statusCode!,
        message: 'fetched kyc status from server',
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final resultData = jsonDecode(result.bodyString!);
        TLoggerHelper.logEvent(
          'KYC Status: ${resultData['response']}',
          eventName: 'checkStatus',
        );
        return KycStatus.fromJson(resultData['response']);
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
        TLoggerHelper.logRefreshAttempt(
          'checkStatus',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return checkStatus(tokens);
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<String> initiateKyc(KycModel request, Map tokens) async {
    try {
      final body = FormData({
        'dob': request.dob,
        'email': request.email,
        'gender': request.gender,
        'country': request.country,
        'userSId': request.userSId,
        'lastname': request.lastname,
        'firstname': request.firstname,
        'issueDate': request.issueDate,
        'expiryDate': request.expiryDate,
        'documentId': request.documentId,
        'phoneNumber': request.phoneNumber,
        'documentType': request.documentType,
        'backIdFile': MultipartFile(
          io.File(request.backIdFile),
          filename: '${request.userSId}_backIdFile.jpg',
        ),
        'selfieFile': MultipartFile(
          io.File(request.selfieFile),
          filename: '${request.userSId}_selfieFile.jpg',
        ),
        'frontIdFile': MultipartFile(
          io.File(request.frontIdFile),
          filename: '${request.userSId}_frontIdFile.jpg',
        ),
      });
      final result = await client.post(
        Env.kycUrl,
        body: body,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      TLoggerHelper.logApiResult(
        httpMethod: 'POST',
        method: 'initiateKyc',
        code: result.statusCode!,
        message: 'User ${tokens['userId']} initiated KYC verification process',
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        TLoggerHelper.logEvent(
          result.bodyString,
          eventName: 'KYC Initiate Response',
        );
        final response = jsonDecode(result.bodyString!);
        return response['response'];
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'initiateKyc',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return initiateKyc(request, tokens);
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (error, stack) {
      TLoggerHelper.logEvent(
        'InitiateKyc error: ${error.runtimeType == BadRequestException ? error : error.toString()}',
        stackTrace: stack,
        eventName: 'KYC Initiation Error',
      );
      if (error is BadRequestException) {
        throw BadRequestException(error.message);
      } else if (error is ServerException) {
        throw ServerException();
      }
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
