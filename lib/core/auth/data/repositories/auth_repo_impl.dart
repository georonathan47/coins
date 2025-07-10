import 'dart:developer' show log;

import 'package:fpdart/fpdart.dart';

import '../../../error/exception.dart';
import '../../../error/failures.dart';
import '../../../platform/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_database.dart';
import '../datasources/auth_remote_database.dart';
import '../models/auth_response.dart';
import '../models/reset_password.dart';
import '../models/verify_otp_model.dart';

class AuthRepoImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthLocalDatabase localDatabase;
  final AuthRemoteDatabase remoteDatabase;

  AuthRepoImpl({
    required this.networkInfo,
    required this.localDatabase,
    required this.remoteDatabase,
  });

  @override
  Future<Either<Failure, AuthResponse>> login(User request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final response = await remoteDatabase.login(request);
        await localDatabase.saveTokens(response);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } on BadRequestException catch (e) {
      return Left(ServerFailure(e.message));
    } on ServerException {
      return Left(Failure('Server error. Please try again later.'));
    } on NoInternetException {
      return Left(
        Failure('No internet connection. Please check your connection.'),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register(User request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final response = await remoteDatabase.register(request);
        await localDatabase.saveTokens(response);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> fetchUserInfo() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await localDatabase.fetchTokens();
        final response = await remoteDatabase.fetchUserInfo(tokens);
        await localDatabase.saveUserInfo(response);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> retrieve() async {
    try {
      final response = await localDatabase.retrieve();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> refreshToken() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await localDatabase.fetchTokens();
        final response = await remoteDatabase.refreshToken(tokens);
        await localDatabase.saveTokens(response);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await localDatabase.fetchTokens();
        final response = await remoteDatabase.logout(tokens);
        await localDatabase.clearTokens();
        await localDatabase.logoutUser();
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(ResetPassword request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final response = await remoteDatabase.resetPassword(request);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> update(User request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final response = await remoteDatabase.update(request);

        await remoteDatabase.fetchUserInfo(await localDatabase.fetchTokens());
        log(response.toString(), name: 'Update User Response');
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendLoginOtp(int userId) async {
    try {
      if (await networkInfo.hasInternet()) {
        final response = await remoteDatabase.sendLoginOtp(
          userId,
          await localDatabase.fetchTokens(),
        );
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(VerifyOtpModel request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final response = await remoteDatabase.verifyLoginOtp(
          request,
          await localDatabase.fetchTokens(),
        );
        // fetchUserInfo(request.userId!);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserInfo(User user) async {
    try {
      final response = await localDatabase.saveUserInfo(user);
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
