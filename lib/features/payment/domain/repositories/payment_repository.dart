import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../data/models/user_payment_details.dart';
import '../entities/dash_portfolio.dart';
import '../entities/pay_account.dart';
import '../entities/payment_details.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentDetails>>> getPaymentDetails(
    String mode,
    String country,
  );
  Future<Either<Failure, void>> deletePayAccount(int id);
  Future<Either<Failure, DashPortfolio>> fetchPortfolio();
  Future<Either<Failure, String>> activate(UserPaymentDetail account);
  Future<Either<Failure, PayAccount>> addPayAccount(PayAccount request);
  Future<Either<Failure, List<UserPaymentDetail>>> fetchPaymentDetails();
}
