import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../data/models/buy_history_model.dart';
import '../../data/models/create_order_response.dart';
import '../../data/models/currency.dart';
import '../../data/models/fee_calc_response.dart';
import '../entities/bank.dart';
import '../entities/coin_data.dart';
import '../entities/country.dart';
import '../entities/create_buy_order.dart';
import '../entities/fee_calculation.dart';
import '../entities/payment_mode.dart';

abstract class BuyRepository {
  /// Fetch all Momo networks
  Future<Either<Failure, List<Bank>>> fetchMomo();

  /// Fetch all banks
  Future<Either<Failure, List<Bank>>> fetchBanks();
  /// Fetch order history
  Future<Either<Failure, List<BuyHistoryModel>>> fetchOrderHistory();
  /// Fetch all countries
  Future<Either<Failure, List<Country>>> fetchCountries();
  Future<Either<Failure, List<CoinData>>> fetchListings();
  Future<Either<Failure, List<CoinData>>> fetchTradableCoins(int countryId);

  /// Fetch all currencies
  Future<Either<Failure, List<Currency>>> fetchCurrencies(int countryId);
  // ? Calculate amount based on selected fee type
  Future<Either<Failure, FeeCalcResponse>> calculateAmount(FeeCalculation fee);

  /// Fetch payment modes by country
  Future<Either<Failure, List<PaymentMode>>> fetchPaymentModes(String country);

  /// Create a buy order
  Future<Either<Failure, CreateBuyOrderResponse>> createBuyOrder(
    CreateBuyOrder order,
  );
}
