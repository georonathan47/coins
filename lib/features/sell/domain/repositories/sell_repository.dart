import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../data/models/sell_history_model.dart';
import '../../data/models/sell_order_response.dart';
import '../entities/create_sell_order.dart';
import '../entities/set_transaction_hash.dart';

abstract class SellRepository {
  Future<Either<Failure, String>> verifyHash(String transactionHash);
  Future<Either<Failure, List<SellHistoryModel>>> fetchOrderHistory();
  Future<Either<Failure, String>> setHash(SetTransactionHash request);
  Future<Either<Failure, SellOrderResponse>> create(SellOrder sellOrder);
}
