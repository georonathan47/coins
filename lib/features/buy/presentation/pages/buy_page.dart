import '../../data/models/currency.dart';
import '../widgets/widgets.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => BuyPageState();
}

class BuyPageState extends State<BuyPage> {
  final textTheme = Get.textTheme;
  final coinData = Get.arguments['coinData'] as CoinData;
  final currency = Get.arguments['currency'] as Currency;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          title: Text(
            'Buy',
            style: textTheme.titleLarge?.copyWith(color: TColors.light),
          ),
        ),
        body: BuyBody(coinData: coinData, currency: currency),
      ),
    );
  }
}
