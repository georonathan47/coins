import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../../data/models/auth_response.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUsecase implements UseCase<AuthResponse, NoParams> {
  /// Constructor
  RefreshTokenUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, AuthResponse>> call(NoParams params) {
    return repository.refreshToken();
  }
}
