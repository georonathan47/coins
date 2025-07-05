import 'package:fpdart/fpdart.dart';

import '../../../../core/auth/data/datasources/auth_local_database.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/bank.dart';
import '../../domain/entities/coin_data.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/create_buy_order.dart';
import '../../domain/entities/fee_calculation.dart';
import '../../domain/entities/payment_mode.dart';
import '../../domain/repositories/buy_repository.dart';
import '../datasources/buy_local_database.dart';
import '../datasources/buy_remote_database.dart';
import '../datasources/currency_local_database.dart';
import '../models/currency.dart';
import '../models/ree_calc_response.dart';

class BuyRepositoryImpl implements BuyRepository {
  final NetworkInfo networkInfo;
  final BuyLocalDatabase localDatabase;
  final BuyRemoteDatabase remoteDatabase;
  final AuthLocalDatabase authLocalDatabase;
  final CurrencyLocalDatabase currencyLocalDatabase;

  BuyRepositoryImpl({
    required this.networkInfo,
    required this.localDatabase,
    required this.remoteDatabase,
    required this.authLocalDatabase,
    required this.currencyLocalDatabase,
  });

  @override
  Future<Either<Failure, List<Country>>> fetchCountries() async {
    final isConnected = await networkInfo.hasInternet();
    if (isConnected) {
      try {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchCountries(tokens);
        await localDatabase.saveCountries(response);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      try {
        final cachedCountries = await localDatabase.retrieve();
        if (cachedCountries.isNotEmpty) {
          return Right(cachedCountries);
        } else {
          return Left(
            Failure(
              'No internet connection and no cached data available. Please check your internet connection and try again!',
            ),
          );
        }
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, FeeCalcResponse>> calculateAmount(
    FeeCalculation fee,
  ) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.calculateFees(fee, tokens);
        return Right(response);
      } else {
        return Left(
          Failure(
            'No internet connection. Please check your internet connection and try again!',
          ),
        );
      }
    } on NoResultException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Currency>>> fetchCurrencies(int countryId) async {
    final isConnected = await networkInfo.hasInternet();
    if (isConnected) {
      try {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchCurrencies(
          countryId,
          tokens,
        );
        await currencyLocalDatabase.saveActualCurrencies(response);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      try {
        final cachedCurrencies = await currencyLocalDatabase.retrieve();
        if (cachedCurrencies.isNotEmpty) {
          return Right(cachedCurrencies);
        } else {
          return Left(
            Failure(
              'No internet connection and no cached data available. Please check your internet connection and try again!',
            ),
          );
        }
      } on CacheException catch (e) {
        return Left(Failure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<CoinData>>> fetchListings() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchListings(tokens);
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

  @override
  Future<Either<Failure, List<CoinData>>> fetchTradableCoins(
    int countryId,
  ) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchTradableCoins(
          countryId,
          tokens,
        );
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

  @override
  Future<Either<Failure, dynamic>> createBuyOrder(CreateBuyOrder order) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final request = order.copyWith(userId: tokens['userId']);
        final response = await remoteDatabase.createOrder(request, tokens);
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

  @override
  Future<Either<Failure, List<PaymentMode>>> fetchPaymentModes(
    String country,
  ) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchPaymentModes(
          country,
          tokens,
        );
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

  @override
  Future<Either<Failure, List<Bank>>> fetchBanks() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchBanks(tokens);
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

  @override
  Future<Either<Failure, List<Momo>>> fetchMomo() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchMomoList(tokens);
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
