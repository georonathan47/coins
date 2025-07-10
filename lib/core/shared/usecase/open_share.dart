import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';
import '../platform/share_info.dart';
import 'usecase.dart';

/// Open an OS share delegate
class OpenShare implements UseCase<bool, ObjectParams<String>> {
  /// Constructor
  OpenShare(this.repository);

  /// Repository
  final ShareInfo repository;

  @override
  Future<Either<Failure, bool>> call(ObjectParams<String> params) {
    return repository.share(params.value);
  }
}
