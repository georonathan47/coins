import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../repositories/sell_repository.dart';

class VerifyHashUsecase extends UseCase<String, ObjectParams<String>> {
  final SellRepository _repository;
  VerifyHashUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(ObjectParams<String> params) {
    return _repository.verifyHash(params.value);
  }
}
