import '../widgets/widgets.dart';

class SellOrderHistory extends StatelessWidget {
  const SellOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          leading: BackButton(onPressed: () => Get.offAllNamed(Routers.index)),
          title: Text(
            'Sell Order History',
            style: Get.textTheme.titleMedium?.copyWith(color: TColors.light),
          ),
        ),
        body: SellOrderHistoryBody(),
      ),
    );
  }
}
