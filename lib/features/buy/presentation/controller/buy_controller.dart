import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/logger.dart';
import '../../data/models/currency.dart';
import '../../data/models/ree_calc_response.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/create_buy_order.dart';
import '../../domain/entities/fee_calculation.dart';
import '../../domain/usecases/fee_calculation_usecase.dart';
import '../../domain/usecases/fetch_currencies_usecase.dart';
import '../../domain/usecases/fetch_listings_usecase.dart';
import '../../domain/usecases/fetch_countries_usecase.dart';
import '../widgets/widgets.dart';

class BuyController extends GetxController {
  final network = ''.obs;
  final eCurrency = ''.obs;
  final currencyId = 0.obs;
  final countries = <Country>[].obs;
  final currencies = <Currency>[].obs;
  final currentUser = User.empty().obs;
  final paymentMode = 'BANK_TRANSFER'.obs;
  final order = CreateBuyOrder.empty().obs;
  final local = TextEditingController().obs;
  final wallet = TextEditingController().obs;
  final dollar = TextEditingController().obs;
  final calcResponse = FeeCalcResponse.empty().obs;
  static BuyController get instance => Get.find();

  final CalculateFeeUsecase calculateFeeUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;
  final FetchListingsUsecase fetchListingsUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;
  final FetchCurrenciesUsecase fetchCurrenciesUsecase;

  BuyController({
    required this.calculateFeeUsecase,
    required this.retrieveUserUsecase,
    required this.fetchListingsUsecase,
    required this.fetchCountriesUsecase,
    required this.fetchCurrenciesUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchCurrencies();
  }

  void clearControllers() {
    network.value = '';
    local.value.clear();
    dollar.value.clear();
    currencyId.value = 0;
    calcResponse.value = FeeCalcResponse.empty();
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      currentUser.value = success;
      update();
      return success;
    });
  }

  Future<List<Country>> fetchCountries() async {
    final result = await fetchCountriesUsecase(NoParams());
    return result.fold((failure) => Future.error(failure.message), (success) {
      countries.value = success;
      update();
      return success;
    });
  }

  Future<List<Currency>> fetchCurrencies() async {
    final user = await retrieveUser();
    final result = await fetchCurrenciesUsecase(ObjectParams(user.countryId!));
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          title: 'Error!',
          message: failure.message,
          bgColor: TColors.error,
        );
        return Future.error(failure.message);
      },
      (success) {
        currencies.value = success;
        update();
        return success;
      },
    );
  }

  Future<FeeCalcResponse> calculate() async {
    final countries = await fetchCountries();
    final country = countries.firstWhere(
      (country) => country.id == currentUser.value.countryId,
      orElse: () => countries.first,
    );
    final request = FeeCalculation(
      country: country,
      currencyId: currencyId.value,
      networkFeeType: network.value,
      paymentMode: paymentMode.value,
      isLocal: local.value.text.isNotEmpty && dollar.value.text.isEmpty,
      amount: dollar.value.text.isEmpty ? local.value.text : dollar.value.text,
    ).obs;
    final result = await calculateFeeUsecase(ObjectParams(request.value));
    Navigator.pop(Get.context!);
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          title: 'Error!',
          message: failure.message,
          bgColor: TColors.error,
        );
        return Future.error(failure.message);
      },
      (success) {
        calcResponse.value = success;
        local.value.text = success.amountLocalCurrency!.toStringAsFixed(2);
        dollar.value.text = success.amountStandardCurrency!.toStringAsFixed(2);
        order.value = order.value.copyWith(
          eCurrency: eCurrency.value,
          paymentMode: paymentMode.value,
          walletAddress: wallet.value.text.trim(),
          total: double.parse(success.usdTotal!.toStringAsFixed(2)),
          buyAmount: double.parse(
            success.amountStandardCurrency!.toStringAsFixed(2),
          ),
          localCurrencyTotal: double.parse(
            success.amountLocalCurrency!.toStringAsFixed(2),
          ),
          networkFee: network.value == 'REGULAR'
              ? double.parse(success.regularNetworkFee!.toStringAsFixed(2))
              : double.parse(success.priorityNetworkFee!.toStringAsFixed(2)),
        );
        TLoggerHelper.logEvent(
          order.value.toJson(),
          eventName: 'Buy Order Request',
        );
        update();
        return success;
      },
    );
  }
}
