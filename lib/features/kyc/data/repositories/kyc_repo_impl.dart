import 'package:fpdart/fpdart.dart';

import '../../../../core/auth/data/datasources/auth_local_database.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/kyc_entity.dart';
import '../../domain/entities/kyc_status.enum.dart';
import '../../domain/repositories/kyc_repository.dart';
import '../datasources/kyc_local_database.dart';
import '../datasources/kyc_remote_database.dart';

class KycRepositoryImpl implements KycRepository {
  final KycRemoteDatabase remoteDatabase;
  final KycLocalDatabase localDatabase;
  final AuthLocalDatabase authLocalDatabase;
  final NetworkInfo networkInfo;

  KycRepositoryImpl({
    required this.authLocalDatabase,
    required this.remoteDatabase,
    required this.localDatabase,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, KycStatus>> checkKycStatus() async {
    try {
      await networkInfo.hasInternet();
      final tokens = await authLocalDatabase.fetchTokens();
      final response = await remoteDatabase.checkStatus(tokens);
      await localDatabase.saveStatus(response);
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> initiateKyc(KycModel request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.initiateKyc(request, tokens);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } on BadRequestException catch (e) {
      return Left(Failure(e.message));
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    } on DeviceException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
