import '../../../../core/auth/domain/usecases/fetch_user_info_usecase.dart';
import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/auth/domain/usecases/save_user_usecase.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../buy/data/models/currency.dart';
import '../../../buy/domain/entities/country.dart';
import '../../../buy/domain/usecases/fetch_countries_usecase.dart';
import '../../../buy/domain/usecases/fetch_currencies_usecase.dart';
import '../../../buy/domain/usecases/fetch_listings_usecase.dart';
import '../../../buy/domain/usecases/fetch_tradable_usecase.dart';
import '../../../buy/presentation/widgets/widgets.dart';
import '../../../kyc/domain/usecases/check_status_usecase.dart';
import '../../../payment/domain/entities/dash_portfolio.dart';
import '../../../payment/domain/usecases/fetch_dash_portfolio_usecase.dart';
import '../widgets/widgets.dart';

class DashboardController extends GetxController {
  final currentUser = User.empty().obs;
  static DashboardController get instance => Get.find();

  final RetrieveUserUsecase retrieveUserUsecase;
  final SaveUserInfoUsecase saveUserInfoUsecase;
  final FetchListingsUsecase fetchListingsUsecase;
  final FetchUserInfoUsecase fetchUserInfoUsecase;
  final CheckKycStatusUsecase checkKycStatusUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;
  final FetchCurrenciesUsecase fetchCurrenciesUsecase;
  final FetchDashPortfolioUsecase fetchDashPortfolioUsecase;
  final FetchTradableCoinsUsecase fetchTradableCoinsUsecase;

  DashboardController({
    required this.retrieveUserUsecase,
    required this.saveUserInfoUsecase,
    required this.fetchListingsUsecase,
    required this.fetchUserInfoUsecase,
    required this.checkKycStatusUsecase,
    required this.fetchCountriesUsecase,
    required this.fetchCurrenciesUsecase,
    required this.fetchDashPortfolioUsecase,
    required this.fetchTradableCoinsUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
    fetchTradables();
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

  Future<List<CoinData>> fetchTradables() async {
    final result = await fetchTradableCoinsUsecase(
      ObjectParams(currentUser.value.countryId ?? 0),
    );
    return result.fold(
      (failure) => Future.error(failure.message),
      (success) => success,
    );
  }

  Future<void> showListingInfo(CoinData currency) async {
    final textTheme = Get.textTheme;
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currency.name,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    child: currency.icon.contains('.svg')
                        ? SvgPicture.network(
                            currency.icon,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: currency.icon,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TFormatter.formatDollar(double.parse(currency.price)),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${currency.percentageChange}%',
                      style: TextStyle(
                        color: currency.percentageChange.contains('+')
                            ? Colors.green
                            : TColors.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Sparkline(
              averageLine: true,
              averageLabel: true,
              useCubicSmoothing: true,
              fillMode: FillMode.below,
              data: currency.sparkline,
              cubicSmoothingFactor: 0.2,
              averageLineColor: TColors.accent,
              lineColor: Get.isDarkMode ? Colors.white : TColors.primary,
              fillGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(int.parse(currency.color.replaceAll('#', '0xFF'))),
                  Color(int.parse(currency.color.replaceAll('#', '0xCF'))),
                  Color(int.parse(currency.color.replaceAll('#', '0xAF'))),
                  Color(int.parse(currency.color.replaceAll('#', '0x26'))),
                  Color(int.parse(currency.color.replaceAll('#', '0x1A'))),
                  Color(int.parse(currency.color.replaceAll('#', '0x0D'))),
                ],
              ),
              gridLineColor: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
      ),
    );
  }

  Future<DashPortfolio> portfolio() async {
    final result = await fetchDashPortfolioUsecase(NoParams());
    return result.fold(
      (failure) => Future.error(failure.message),
      (success) => success,
    );
  }
}
