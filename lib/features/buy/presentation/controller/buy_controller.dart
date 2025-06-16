import '../../../../core/usecase/usecase.dart';
import '../../data/models/ree_calc_response.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/fee_calculation.dart';
import '../../domain/usecases/fee_calculation_usecase.dart';
import '../../domain/usecases/fetch_listings_usecase.dart';
import '../../domain/usecases/fetch_countries_usecase.dart';
import '../widgets/widgets.dart';

class BuyController extends GetxController {
  final currencyId = 0.obs;
  final network = 'MOBILE_MONEY'.obs;
  final paymentMode = 'BANK_TRANSFER'.obs;
  final local = TextEditingController().obs;
  final dollar = TextEditingController().obs;
  final calcResponse = FeeCalcResponse().obs;
  static BuyController get instance => Get.find();

  final CalculateFeeUsecase calculateFeeUsecase;
  final FetchListingsUsecase fetchListingsUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;

  BuyController({
    required this.calculateFeeUsecase,
    required this.fetchListingsUsecase,
    required this.fetchCountriesUsecase,
  });

  Future<FeeCalcResponse> calculate() async {
    final request = FeeCalculation(
      country: Country.empty(),
      currencyId: currencyId.value,
      networkFeeType: network.value,
      paymentMode: paymentMode.value,
      isLocal: local.value.text.isNotEmpty,
      amount: dollar.value.text.isEmpty ? local.value.text : dollar.value.text,
    ).obs;
    final result = await calculateFeeUsecase(ObjectParams(request.value));
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
        calcResponse.value = success;
        update();
        return success;
      },
    );
  }
}
