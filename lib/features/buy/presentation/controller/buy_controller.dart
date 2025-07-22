import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../../../core/shared/utils/logger.dart';
import '../../../payment/domain/entities/payment_details.dart';
import '../../../payment/domain/usecases/get_payment_details_usecase.dart';
import '../../data/models/buy_history_model.dart';
import '../../data/models/create_order_response.dart';
import '../../data/models/currency.dart';
import '../../data/models/fee_calc_response.dart';
import '../../domain/entities/bank.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/create_buy_order.dart';
import '../../domain/entities/fee_calculation.dart';
import '../../domain/entities/payment_mode.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/fee_calculation_usecase.dart';
import '../../domain/usecases/fetch_banks_usecase.dart';
import '../../domain/usecases/fetch_buy_history_usecase.dart';
import '../../domain/usecases/fetch_currencies_usecase.dart';
import '../../domain/usecases/fetch_listings_usecase.dart';
import '../../domain/usecases/fetch_countries_usecase.dart';
import '../../domain/usecases/fetch_momo_list_usecase.dart';
import '../../domain/usecases/fetch_payment_modes_usecase.dart';
import '../widgets/widgets.dart';

class BuyController extends GetxController {
  final eCurrency = ''.obs;
  final currencyId = 0.obs;
  final momo = <Bank>[].obs;
  final paymentType = ''.obs;
  final banks = <Bank>[].obs;
  final filterStatus = ''.obs;
  final network = 'REGULAR'.obs;
  final countries = <Country>[].obs;
  final currencies = <Currency>[].obs;
  final payModes = <PaymentMode>[].obs;
  final currentUser = User.empty().obs;
  final details = <PaymentDetails>[].obs;
  final paymentMode = 'BANK_TRANSFER'.obs;
  final order = CreateBuyOrder.empty().obs;
  final name = TextEditingController().obs;
  final local = TextEditingController().obs;
  final wallet = TextEditingController().obs;
  final dollar = TextEditingController().obs;
  final number = TextEditingController().obs;
  static BuyController get instance => Get.find();
  final calcResponse = FeeCalcResponse.empty().obs;
  final transactionId = TextEditingController().obs;

  final FetchMomoUsecase fetchMomoUsecase;
  final FetchBanksUsecase fetchBanksUsecase;
  final CalculateFeeUsecase calculateFeeUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;
  final FetchListingsUsecase fetchListingsUsecase;
  final CreateBuyOrderUsecase createBuyOrderUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;
  final FetchBuyHistoryUsecase fetchBuyHistoryUsecase;
  final FetchCurrenciesUsecase fetchCurrenciesUsecase;
  final FetchPaymentModesUsecase fetchPaymentModesUsecase;
  final GetPaymentDetailsUsecase getPaymentDetailsUsecase;

  BuyController({
    required this.fetchMomoUsecase,
    required this.fetchBanksUsecase,
    required this.calculateFeeUsecase,
    required this.retrieveUserUsecase,
    required this.fetchListingsUsecase,
    required this.createBuyOrderUsecase,
    required this.fetchCountriesUsecase,
    required this.fetchBuyHistoryUsecase,
    required this.fetchCurrenciesUsecase,
    required this.fetchPaymentModesUsecase,
    required this.getPaymentDetailsUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    Future.any([
      retrieveUser(),
      fetchCountries(),
      fetchCurrencies(),
      fetchBanks(),
      fetchMomo(),
    ]);
    network.value = 'REGULAR';
  }

  void clearControllers() {
    network.value = '';
    local.value.clear();
    dollar.value.clear();
    currencyId.value = 0;
    paymentMode.value = '';
    paymentType.value = '';
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

  Future<List<PaymentMode>> fetchPaymentModes() async {
    final user = await retrieveUser();
    final country = countries.firstWhere(
      (country) => country.id == user.countryId,
      orElse: () => Country.empty(),
    );
    final result = await fetchPaymentModesUsecase(
      ObjectParams(country.countryName),
    );
    Get.back();
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
        payModes.value = success;
        update();
        Get.toNamed(Routers.paymentSelection);
        return success;
      },
    );
  }

  Future<List<Bank>> fetchBanks() async {
    final result = await fetchBanksUsecase(NoParams());
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
        banks.value = success;
        update();
        return success;
      },
    );
  }

  Future<List<PaymentDetails>> fetchPayDetails() async {
    final user = await retrieveUser();
    final country = countries.firstWhere(
      (country) => country.id == user.countryId,
      orElse: () => Country.empty(),
    );
    final result = await getPaymentDetailsUsecase(
      ObjectParams(paymentMode.value),
      ObjectParams(country.countryName),
    );
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
        details.value = success;
        update();
        return success;
      },
    );
  }

  Future<List<Bank>> fetchMomo() async {
    final result = await fetchMomoUsecase(NoParams());
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
        momo.value = success;
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
    );
    final result = await calculateFeeUsecase(ObjectParams(request));
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

  Future<CreateBuyOrderResponse> createOrder() async {
    final request = order.value.copyWith(
      nameOnAccount: name.value.text.trim(),
      walletAddress: wallet.value.text.trim(),
      accountNumber: number.value.text.trim(),
      transactionDetails: transactionId.value.text.trim(),
    );
    TLoggerHelper.logEvent(request.toJson(), eventName: 'Create Buy Order');
    final result = await createBuyOrderUsecase(ObjectParams(request));
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
        THelperFunctions.showSnackBar(
          title: 'Success!',
          message: 'Order created successfully',
          bgColor: TColors.success,
        );
        Get.toNamed(Routers.buySuccess);
        return success;
      },
    );
  }

  Future<List<BuyHistoryModel>> history() async {
    final result = await fetchBuyHistoryUsecase(NoParams());
    return result.fold((failure) {
      THelperFunctions.showSnackBar(
        title: 'Error!',
        message: failure.message,
        bgColor: TColors.error,
      );
      return Future.error(failure.message);
    }, (success) => success);
  }
}
