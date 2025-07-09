import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/dash_portfolio.dart';
import '../entities/payment_details.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentDetails>>> getPaymentDetails(
    String mode,
    String country,
  );

  Future<Either<Failure, DashPortfolio>> fetchPortfolio();
}
