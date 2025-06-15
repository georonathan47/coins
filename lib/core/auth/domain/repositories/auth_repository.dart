import 'package:fpdart/fpdart.dart';

import '../../../error/failures.dart';
import '../../data/models/auth_response.dart';
import '../../data/models/reset_password.dart';
import '../../data/models/verify_otp_model.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> retrieve();
  Future<Either<Failure, User>> fetchUserInfo();
  Future<Either<Failure, String>> update(User request);
  Future<Either<Failure, AuthResponse>> refreshToken();
  Future<Either<Failure, String>> sendLoginOtp(int userId);
  Future<Either<Failure, AuthResponse>> login(User request);
  Future<Either<Failure, AuthResponse>> register(User request);
  Future<Either<Failure, String>> verifyOtp(VerifyOtpModel otp);
  Future<Either<Failure, String>> resetPassword(ResetPassword request);
}
