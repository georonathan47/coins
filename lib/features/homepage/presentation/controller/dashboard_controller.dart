import '../../../../core/auth/domain/usecases/fetch_user_info_usecase.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/auth/domain/usecases/save_user_usecase.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../buy/data/models/currency.dart';
import '../../../buy/domain/entities/coin_data.dart';
import '../../../buy/domain/entities/country.dart';
import '../../../buy/domain/usecases/fetch_countries_usecase.dart';
import '../../../buy/domain/usecases/fetch_currencies_usecase.dart';
import '../../../buy/domain/usecases/fetch_listings_usecase.dart';
import '../widgets/widgets.dart';

class DashboardController extends GetxController {
  final currentUser = User.empty().obs;
  static DashboardController get instance => Get.find();

  final RetrieveUserUsecase retrieveUserUsecase;
  final SaveUserInfoUsecase saveUserInfoUsecase;
  final FetchListingsUsecase fetchListingsUsecase;
  final FetchUserInfoUsecase fetchUserInfoUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;

  final FetchCurrenciesUsecase fetchCurrenciesUsecase;
  DashboardController({
    required this.retrieveUserUsecase,
    required this.saveUserInfoUsecase,
    required this.fetchListingsUsecase,
    required this.fetchUserInfoUsecase,
    required this.fetchCountriesUsecase,
    required this.fetchCurrenciesUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    // retrieveUser();
    fetchUserDetails();
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      currentUser.value = success;
      update();
      return success;
    });
  }

  Future<void> openTrade() async {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: TColors.transparent,
      context: (Get.context!),
      builder: (context) => TradeModalSheet(),
    );
  }

  Future<User> fetchUserDetails() async {
    final result = await fetchUserInfoUsecase(NoParams());
    return result.fold((failure) => Future.error(failure.message), (
      success,
    ) async {
      final country = await countries().then(
        (countries) => countries.firstWhere(
          (country) => country.countryName == success.country,
          orElse: () => Country.empty(),
        ),
      );
      currentUser.value = success.copyWith(
        country: country.countryName,
        countryId: country.id,
      );
      update();
      await saveUserInfo(currentUser.value);
      return success;
    });
  }

  Future<List<Currency>> fetchCurrencies() async {
    final result = await fetchCurrenciesUsecase(
      ObjectParams(currentUser.value.countryId!),
    );
    return result.fold(
      (failure) => Future.error(failure.message),
      (success) => success,
    );
  }

  Future<List<Country>> countries() async {
    final countries = await fetchCountriesUsecase(NoParams());
    return countries.fold(
      (failure) => Future.error(failure.message),
      (success) => success,
    );
  }

  Future<void> saveUserInfo(User user) async {
    final result = await saveUserInfoUsecase(ObjectParams(user));
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          title: 'Error',
          message: failure.message,
          bgColor: TColors.error,
        );
      },
      (success) {
        currentUser.value = user;
        update();
      },
    );
  }

  Future<List<CoinData>> fetchListings() async {
    final result = await fetchListingsUsecase(NoParams());
    return result.fold(
      (failure) => Future.error(failure.message),
      (success) => success,
    );
  }
}
