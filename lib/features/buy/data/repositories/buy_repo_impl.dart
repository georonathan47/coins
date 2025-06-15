import 'package:fpdart/fpdart.dart';

import '../../../../core/auth/data/datasources/auth_local_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/country.dart';
import '../../domain/repositories/buy_repository.dart';
import '../datasources/buy_remote_database.dart';

class BuyRepositoryImpl implements BuyRepository {
  final NetworkInfo networkInfo;
  final AuthLocalDatabase localDatabase;
  final BuyRemoteDatabase remoteDatabase;

  BuyRepositoryImpl({
    required this.networkInfo,
    required this.localDatabase,
    required this.remoteDatabase,
  });

  @override
  Future<Either<Failure, List<Country>>> fetchCountries() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await localDatabase.fetchTokens();
        final response = await remoteDatabase.fetchCountries(tokens);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
