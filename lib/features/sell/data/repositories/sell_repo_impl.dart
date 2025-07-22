import 'package:fpdart/fpdart.dart';

import '../../../../core/auth/data/datasources/auth_local_database.dart';
import '../../../../core/shared/constants/text_strings.dart';
import '../../../../core/shared/error/exception.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/platform/network_info.dart';
import '../../domain/entities/create_sell_order.dart';
import '../../domain/entities/set_transaction_hash.dart';
import '../../domain/repositories/sell_repository.dart';
import '../datasources/sell_remote_database.dart';
import '../models/sell_history_model.dart';
import '../models/sell_order_response.dart';

class SellRepositoryImpl implements SellRepository {
  final NetworkInfo networkInfo;
  final SellRemoteDatabase remoteDatabase;
  final AuthLocalDatabase authLocalDatabase;
  SellRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
    required this.authLocalDatabase,
  });

  @override
  Future<Either<Failure, SellOrderResponse>> create(SellOrder sellOrder) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.createOrder(sellOrder, tokens);
        return Right(response);
      } else {
        return Left(NetworkFailure(TTexts.noInternetMessage));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on BadRequestException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setHash(SetTransactionHash request) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.setHash(request, tokens);
        return Right(response);
      } else {
        return Left(NetworkFailure(TTexts.noInternetMessage));
      }
    } on ConflictException catch (e) {
      return Left(ConflictFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on BadRequestException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyHash(String hashId) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.verifyHash(hashId, tokens);
        return Right(response);
      } else {
        return Left(NetworkFailure(TTexts.noInternetMessage));
      }
    } on ConflictException catch (e) {
      return Left(ConflictFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on BadRequestException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SellHistoryModel>>> fetchOrderHistory() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchOrderHistory(tokens);
        return Right(response);
      } else {
        return Left(NetworkFailure(TTexts.noInternetMessage));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on BadRequestException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
