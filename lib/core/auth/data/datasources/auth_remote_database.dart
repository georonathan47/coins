import 'dart:convert';
import 'package:get/get_connect.dart';

import '../../../../flavors.dart';
import '../../../shared/utils/encryption.dart';
import '../models/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../../shared/constants/env.dart';
import '../../../shared/error/exception.dart';
import '../../../shared/utils/logger.dart';
import '../models/reset_password.dart';
import '../models/verify_otp_model.dart';

abstract class AuthRemoteDatabase {
  Future<void> logout(Map tokens);
  Future<String> update(User request);
  Future<User> fetchUserInfo(Map tokens);
  Future<AuthResponse> login(User request);
  Future<AuthResponse> register(User request);
  Future<AuthResponse> refreshToken(Map tokens);
  Future<String> sendLoginOtp(int userId, Map tokens);
  Future<String> resetPassword(ResetPassword request);
  Future<String> verifyLoginOtp(VerifyOtpModel request, Map tokens);
}

class AuthRemoteDatabaseImpl implements AuthRemoteDatabase {
  final GetHttpClient client;
  AuthRemoteDatabaseImpl({required this.client});

  @override
  Future<AuthResponse> login(User user) async {
    try {
      final encrypted = encryptField('CLIENT');
      final jsonBody = {
        "rememberMe": true,
        "email": user.email,
        "password": user.password,
        "authType": encrypted.base64,
        'captchaResponse': F.appFlavor.name == 'dev'
            ? '20000000-aaaa-bbbb-cccc-000000000002'
            : user.captchaResponse,
      };
      final result = await client.post(
        Env.authenticateUrl,
        body: jsonEncode(jsonBody),
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return AuthResponse.fromJson(result.body);
      } else if (result.statusCode! == 400) {
        final body = jsonDecode(result.bodyString!);
        throw BadRequestException(body['message']);
      } else if (result.statusCode! == 404) {
        final body = jsonDecode(result.body);
        throw BadRequestException(body['message']);
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      if (error is BadRequestException) {
        throw BadRequestException(error.message);
      } else if (error is ServerException) {
        throw ServerException(error.message);
      }
      throw Exception();
    }
  }

  @override
  Future<AuthResponse> register(User user) async {
    try {
      final jsonBody = {
        "email": user.email,
        "country": user.country,
        "lastname": user.lastname,
        "password": user.password,
        "firstname": user.firstname,
        "phoneNumber": user.phoneNumber,
        'captchaResponse': F.appFlavor.name == 'dev'
            ? '20000000-aaaa-bbbb-cccc-000000000002'
            : user.captchaResponse,
      };
      final result = await client.post(
        '${Env.baseUrl}/auth/register',
        body: jsonEncode(jsonBody),
      );
      TLoggerHelper.logApiResult(
        httpMethod: 'POST',
        method: 'register user',
        code: result.statusCode!,
        message: 'AuthRemoteDatabase.register()',
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return AuthResponse.fromJson(result.body);
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<User> fetchUserInfo(Map tokens) async {
    try {
      final result = await client.get(
        '${Env.baseUrl}/auth/user/get?userId=${tokens['userId']}',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      TLoggerHelper.logApiResult(
        httpMethod: 'GET',
        method: 'fetchUserInfo',
        code: result.statusCode!,
        message: 'AuthRemoteDatabase.fetchUserInfo()',
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final data = User.fromJson(result.body);

        return data;
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<AuthResponse> refreshToken(Map tokens) async {
    try {
      final result = await client.post(
        '${Env.baseUrl}/auth/refresh-token',
        headers: {'Authorization': 'Bearer ${tokens['refreshToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final data = AuthResponse.fromJson(result.body);
        return data;
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<void> logout(Map tokens) async {
    try {
      final result = await client.post(
        '${Env.baseUrl}/auth/logout',
        headers: {'Authorization': 'Bearer ${tokens['refreshToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return;
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<String> resetPassword(ResetPassword request) async {
    try {
      final result = await client.post(
        '${Env.baseUrl}/auth/password/update',
        body: jsonEncode(request.toJson()),
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return 'Password changed successfully!';
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<String> update(User user) async {
    try {
      // final jsonBody = FormData({
      //   "email": user.email,
      //   "userId": user.userId,
      //   "gender": user.gender,
      //   "lastname": user.lastname,
      //   "firstname": user.firstname,
      //   "phoneNumber": user.phoneNumber,
      //   "image": MultipartFile(
      //     io.File(user.userProfileImage!),
      //     filename: '${user.username}.jpg',
      //   ),
      // });
      final result = await client.post(
        '${Env.baseUrl}/auth/profile',
        // body: jsonBody,
      );
      TLoggerHelper.logApiResult(
        httpMethod: 'POST',
        method: 'update user',
        code: result.statusCode!,
        message: 'AuthRemoteDatabase.update()',
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return "User profile updated successfully!";
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<String> sendLoginOtp(int userId, Map tokens) async {
    try {
      final result = await client.get(
        '${Env.sendOtpUrl}?userId=$userId&otpType=EMAIL',
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        // this returns full user data
        return 'OTP sent successfully!';
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<String> verifyLoginOtp(VerifyOtpModel request, Map tokens) async {
    try {
      TLoggerHelper.logEvent(
        '${Env.verifyOtpUrl}?userId=${tokens['userId']}&otp=${request.otp}&otpType=${request.type}&activateAccount=true',
      );
      final result = await client.get(
        '${Env.verifyOtpUrl}?userId=${tokens['userId']}&otp=${request.otp}&otpType=${request.type}&activateAccount=true',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        // this returns full user data
        return 'OTP successfully verified!';
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (error) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
