import '../../../../core/auth/domain/usecases/retrieve_user.dart';
import '../../../../core/usecase/usecase.dart';
import '../widgets/widgets.dart';

class DashboardController extends GetxController {
  final currentUser = User.empty().obs;
  static DashboardController get instance => Get.find();

  final RetrieveUserUsecase retrieveUserUsecase;
  DashboardController({required this.retrieveUserUsecase});

  @override
  void onInit() {
    super.onInit();
    retrieveUser();
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
}
