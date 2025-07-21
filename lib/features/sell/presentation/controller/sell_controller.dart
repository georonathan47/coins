import 'dart:developer';

import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../../../core/shared/utils/logger.dart';
import '../../../buy/domain/entities/fee_calculation.dart';
import '../../../buy/presentation/controller/buy_controller.dart';
import '../../../payment/data/models/user_payment_details.dart';
import '../../../payment/domain/usecases/user_payment_details_usecase.dart';
import '../../data/models/sell_order_response.dart';
import '../../domain/entities/create_sell_order.dart';
import '../../domain/entities/set_transaction_hash.dart';
import '../../domain/usecases/create_sell_order_usecase.dart';
import '../../domain/usecases/set_hash_usecase.dart';
import '../../domain/usecases/verify_hash_usecase.dart';
import '../widgets/widgets.dart';

class SellController extends GetxController {
  final eCurrency = ''.obs;
  final currencyId = 0.obs;
  final network = 'REGULAR'.obs;
  final order = SellOrder.empty().obs;
  final currentUser = User.empty().obs;
  final paymentMode = 'BANK_TRANSFER'.obs;
  final hash = TextEditingController().obs;
  final phone = TextEditingController().obs;
  final local = TextEditingController().obs;
  final dollar = TextEditingController().obs;
  final accName = TextEditingController().obs;
  final accType = TextEditingController().obs;
  final accNumber = TextEditingController().obs;
  final calcResponse = FeeCalcResponse.empty().obs;
  static SellController get instance => Get.find();
  final setHashRqst = SetTransactionHash.empty().obs;
  final userPaymentDetails = <UserPaymentDetail>[].obs;
  final selectedRecipient = UserPaymentDetail.empty().obs;

  // Add your methods and properties here
  int currentStep = 0;
  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final SetHashUsecase setHashUsecase;
  final VerifyHashUsecase verifyHashUsecase;
  final CalculateFeeUsecase calculateFeeUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;
  final CreateSellOrderUsecase createSellOrderUsecase;
  final FetchUserPaymentDetailsUseCase fetchUserPaymentDetailsUseCase;

  SellController({
    required this.setHashUsecase,
    required this.verifyHashUsecase,
    required this.calculateFeeUsecase,
    required this.retrieveUserUsecase,
    required this.createSellOrderUsecase,
    required this.fetchUserPaymentDetailsUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    retrieveUser();
    fetchUserPaymentDetails();
  }

  void onStepTapped(int step) {
    currentStep = step;
    update();
  }

  void onStepContinue() async {
    final isLastStep = currentStep == 3;
    if (currentStep == 0 && selectedRecipient.value.id < 1) {
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
        await createOrder();
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
        update();
        return success;
      },
    );
  }

  void setSelectedRecipient(UserPaymentDetail value) {
    selectedRecipient.value = value;
  }

  Future<String> verifyHash() async {
    final result = await verifyHashUsecase(ObjectParams(hash.value.text));
    return result.fold(
      (failure) {
        Get.back();
        log(failure.toString());
        THelperFunctions.showSnackBar(
          title: 'Error',
          message: failure.message,
          bgColor: TColors.error,
        );
        return failure.message;
      },
      (success) async {
        if (success.contains('Valid')) {
          await createOrder();
        } else {
          Get.back();
          THelperFunctions.showSnackBar(
            title: 'Error',
            message: '$success transaction Id',
            bgColor: TColors.error,
          );
        }
        return success;
      },
    );
  }

  Future<SellOrderResponse> createOrder() async {
    final user = await retrieveUser();
    final request = order.value.copyWith(
      userId: user.userId,
      ecurrency: eCurrency.value,
      paymentMode: paymentMode.value,
      bankName: accName.value.text.trim(),
      phoneNumber: phone.value.text.trim(),
      accountType: accType.value.text.trim(),
      senderSName: currentUser.value.fullName,
      nameOnAccount: accName.value.text.trim(),
      accountNumber: accNumber.value.text.trim(),
      overAllTotal: double.parse(
        calcResponse.value.usdTotal!.toStringAsFixed(2),
      ),
      sellAmount: double.parse(
        calcResponse.value.amountStandardCurrency!.toStringAsFixed(2),
      ),
      localCurrencyTotal: double.parse(
        calcResponse.value.amountLocalCurrency!.toStringAsFixed(2),
      ),
      networkFee: double.parse(
        calcResponse.value.regularNetworkFee!.toStringAsFixed(2),
      ),
    );
    final result = await createSellOrderUsecase(ObjectParams(request));
    Get.back();
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          title: 'Error',
          message: failure.message,
          bgColor: TColors.error,
        );
        return Future.error(failure.message);
      },
      (success) async {
        THelperFunctions.showSnackBar(
          title: 'Success',
          bgColor: TColors.success,
          message: 'Order created successfully!',
        );
        await setHash(success.orderId);
        return success;
      },
    );
  }

  Future setHash(String orderId) async {
    final result = await setHashUsecase(
      ObjectParams(
        setHashRqst.value.copyWith(orderId: orderId, hashId: hash.value.text),
      ),
    );
    return result.fold(
      (failure) => Future.error(failure.message),
      (success) {
        Get.offNamed(Routers.sellSuccess);
        return success;},
    );
  }

  Future<List<UserPaymentDetail>> fetchUserPaymentDetails() async {
    final result = await fetchUserPaymentDetailsUseCase(NoParams());
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          title: 'Error',
          message: failure.message,
          bgColor: TColors.error,
        );
        return Future.error(failure.message);
      },
      (success) {
        userPaymentDetails.value = success;
        TLoggerHelper.logEvent(
          success.map((e) => e.toJson()).toList(),
          eventName: 'User Payment Details',
        );
        update();
        return success;
      },
    );
  }
}
