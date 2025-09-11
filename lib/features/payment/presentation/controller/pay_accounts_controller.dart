import '../../../../core/auth/domain/entities/user.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../../buy/domain/entities/country.dart';
import '../../../buy/domain/usecases/fetch_banks_usecase.dart';
import '../../../buy/domain/usecases/fetch_countries_usecase.dart';
import '../../../buy/domain/usecases/fetch_momo_list_usecase.dart';
import '../../data/models/user_payment_details.dart';
import '../../domain/entities/pay_account.dart';
import '../../domain/usecases/add_pay_account_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../../domain/usecases/user_payment_details_usecase.dart';
import '../widgets/widgets.dart';

class PayAccountsController extends GetxController {
  final FetchMomoUsecase fetchMomoUsecase;
  final FetchBanksUsecase fetchBanksUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;
  final AddPayAccountUsecase addPayAccountUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;
  final DeletePayAccountUsecase deletePayAccountUsecase;
  final FetchUserPaymentDetailsUseCase fetchUserPaymentDetailsUseCase;

  PayAccountsController({
    required this.fetchMomoUsecase,
    required this.fetchBanksUsecase,
    required this.retrieveUserUsecase,
    required this.addPayAccountUsecase,
    required this.fetchCountriesUsecase,
    required this.deletePayAccountUsecase,
    required this.fetchUserPaymentDetailsUseCase,
  });

  final isBankAccount = false.obs;
  final countryList = <Country>[].obs;
  final bankAccountTypes = ['Personal', 'Business'];
  final types = ['Bank Account', 'Momo Account'].obs;
  final userPaymentDetails = <UserPaymentDetail>[].obs;
  final momoAccountTypes = ['Agent', 'Merchant', 'Subscriber'];

  final bankController = TextEditingController();
  final momoController = TextEditingController();
  final addAccountFormKey = GlobalKey<FormState>();
  final bankNameController = TextEditingController();
  final momoNameController = TextEditingController();
  final bankCodeController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final momoNetworkCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
    fetchUserPaymentDetails();
  }

  void openAccount() {
    showModalBottomSheet(
      useSafeArea: true,
      context: (Get.context!),
      backgroundColor: TColors.transparent,
      builder: (context) => PayAccountsModalSheet(),
    );
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      update();
      return success;
    });
  }

  void setAccountType(bool value) {
    isBankAccount.value = value;
  }

  Future<List<Country>> fetchCountries() async {
    final result = await fetchCountriesUsecase(NoParams());
    return result.fold((failure) => Future.error(failure.message), (success) {
      countryList.value = success;
      update();
      return success;
    });
  }

  Future<PayAccount> addAccount(PayAccount request) async {
    final user = await retrieveUser();

    final result = await addPayAccountUsecase(
      ObjectParams(request.copyWith(userId: user.userId)),
    );
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
      (success) {
        THelperFunctions.showSnackBar(
          title: 'Success',
          bgColor: TColors.success,
          message: 'Account added successfully!',
        );
        return success;
      },
    );
  }

  Future<void> deleteAccount(int id) async {
    final result = await deletePayAccountUsecase(ObjectParams(id));
    return result.fold((failure) {
      THelperFunctions.showSnackBar(
        title: 'Error',
        message: failure.message,
        bgColor: TColors.error,
      );
      return Future.error(failure.message);
    }, (success) => success);
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
        update();
        return success;
      },
    );
  }
}
