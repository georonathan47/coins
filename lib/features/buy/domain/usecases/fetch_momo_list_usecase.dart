import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/bank.dart';
import '../repositories/buy_repository.dart';

class FetchMomoUsecase extends UseCase<List<Momo>, NoParams> {
  FetchMomoUsecase(this._repository);
  final BuyRepository _repository;

  @override
  Future<Either<Failure, List<Momo>>> call(NoParams params) {
    return _repository.fetchMomo();
  }
}
