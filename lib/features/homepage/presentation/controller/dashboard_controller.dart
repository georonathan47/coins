import '../widgets/widgets.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();
  DashboardController();

  Future<void> openTrade() async {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: TColors.transparent,
      context: (Get.context!),
      builder: (context) => TradeModalSheet(),
    );
  }
}
