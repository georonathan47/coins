import '../widgets/widgets.dart';

class BuyOrderHistory extends StatelessWidget {
  const BuyOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          leading: BackButton(onPressed: () => Get.offAllNamed(Routers.index)),
          title: Text(
            'Buy Order History',
            style: Get.textTheme.titleLarge?.copyWith(color: TColors.light),
          ),
        ),
        body: BuyOrderHistoryBody(),
      ),
    );
  }
}
