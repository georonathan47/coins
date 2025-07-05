import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/bank.dart';
import '../repositories/buy_repository.dart';

class FetchBanksUsecase extends UseCase<List<Bank>, NoParams> {
  FetchBanksUsecase(this._repository);
  final BuyRepository _repository;

  @override
  Future<Either<Failure, List<Bank>>> call(NoParams params) {
    return _repository.fetchBanks();
  }
}
