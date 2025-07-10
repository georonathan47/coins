import 'package:fpdart/fpdart.dart';

import '../../../../core/auth/data/datasources/auth_local_database.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/platform/network_info.dart';
import '../../domain/entities/dash_portfolio.dart';
import '../../domain/entities/payment_details.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_database.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final NetworkInfo networkInfo;
  final AuthLocalDatabase authLocalDatabase;
  final PaymentRemoteDatabase remoteDatabase;

  PaymentRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
    required this.authLocalDatabase,
  });

  @override
  Future<Either<Failure, List<PaymentDetails>>> getPaymentDetails(
    String mode,
    String country,
  ) async {
    try {
      await networkInfo.hasInternet();
      final tokens = await authLocalDatabase.fetchTokens();
      final response = await remoteDatabase.getPaymentDetails(
        mode,
        country,
        tokens,
      );
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashPortfolio>> fetchPortfolio() async {
    try {
      await networkInfo.hasInternet();
      final tokens = await authLocalDatabase.fetchTokens();
      final response = await remoteDatabase.fetchPortfolio(tokens);
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
