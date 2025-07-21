import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/set_transaction_hash.dart';
import '../repositories/sell_repository.dart';

class SetHashUsecase extends UseCase<String, ObjectParams<SetTransactionHash>> {
  final SellRepository _repository;

  SetHashUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(ObjectParams<SetTransactionHash> params) {
    return _repository.setHash(params.value);
  }
}
