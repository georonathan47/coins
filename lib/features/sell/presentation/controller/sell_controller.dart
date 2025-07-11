import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../../buy/domain/entities/fee_calculation.dart';
import '../../../buy/presentation/controller/buy_controller.dart';
import '../widgets/widgets.dart';

class SellController extends GetxController {
  final eCurrency = ''.obs;
  final currencyId = 0.obs;
  final network = 'REGULAR'.obs;
  final selectedRecipient = ''.obs;
  final currentUser = User.empty().obs;
  final paymentMode = 'BANK_TRANSFER'.obs;
  final hash = TextEditingController().obs;
  final phone = TextEditingController().obs;
  final local = TextEditingController().obs;
  final dollar = TextEditingController().obs;
  final accName = TextEditingController().obs;
  final accType = TextEditingController().obs;
  final calcResponse = FeeCalcResponse.empty().obs;
  static SellController get instance => Get.find();

  // Add your methods and properties here
  int currentStep = 0;
  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final CalculateFeeUsecase calculateFeeUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;

  SellController({
    required this.calculateFeeUsecase,
    required this.retrieveUserUsecase,
  });
  @override
  void onInit() {
    super.onInit();
    retrieveUser();
  }

  void onStepTapped(int step) {
    currentStep = step;
    update();
  }

  void onStepContinue() {
    final isLastStep = currentStep == 3;
    if (currentStep == 0 && selectedRecipient.value.isEmpty) {
      THelperFunctions.showSnackBar(
        title: 'Error!',
        bgColor: TColors.error,
        message: 'Please select a recipient.',
      );
      return;
    } else if (formKeys[currentStep].currentState!.validate()) {
      if (isLastStep) {
        showDialog(
          context: Get.context!,
          builder: (ctx) {
            return const Center(child: CircularProgressIndicator());
          },
        );
        // submit form
        return;
      }
      currentStep += 1;
      update();
    } else {
      THelperFunctions.showSnackBar(
        title: 'Error!',
        bgColor: TColors.error,
        message: 'Please fill all required fields.',
      );
    }
  }

  void onStepCancel() {
    if (currentStep > 0) {
      currentStep -= 1;
      update();
    }
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      currentUser.value = success;
      update();
      return success;
    });
  }

  Future<FeeCalcResponse> calculate() async {
    final countries = await Get.find<BuyController>().fetchCountries();
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
        // order.value = order.value.copyWith(
        //   eCurrency: eCurrency.value,
        //   paymentMode: paymentMode.value,
        //   // walletAddress: wallet.value.text.trim(),
        //   total: double.parse(success.usdTotal!.toStringAsFixed(2)),
        //   buyAmount: double.parse(
        //     success.amountStandardCurrency!.toStringAsFixed(2),
        //   ),
        //   localCurrencyTotal: double.parse(
        //     success.amountLocalCurrency!.toStringAsFixed(2),
        //   ),
        //   networkFee: network.value == 'REGULAR'
        //       ? double.parse(success.regularNetworkFee!.toStringAsFixed(2))
        //       : double.parse(success.priorityNetworkFee!.toStringAsFixed(2)),
        // );
        // TLoggerHelper.logEvent(
        //   order.value.toJson(),
        //   eventName: 'Sell Order Request',
        // );
        update();
        return success;
      },
    );
  }

  void setSelectedRecipient(String value) {
    selectedRecipient.value = value;
  }
}
