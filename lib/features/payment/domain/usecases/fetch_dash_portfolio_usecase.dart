import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dash_portfolio.dart';
import '../repositories/payment_repository.dart';

class FetchDashPortfolioUsecase extends UseCase<DashPortfolio, NoParams> {
  FetchDashPortfolioUsecase(this.repository);
  final PaymentRepository repository;

  @override
  Future<Either<Failure, DashPortfolio>> call(NoParams params) {
    return repository.fetchPortfolio();
  }
}
