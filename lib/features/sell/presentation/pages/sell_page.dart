import '../widgets/widgets.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => SellPageState();
}

class SellPageState extends State<SellPage> {
  final textTheme = Get.textTheme;
  final instance = SellController.instance;
  final coinData = Get.arguments['coinData'] as CoinData;
  final currency = Get.arguments['currency'] as Currency;

  @override
  void initState() {
    super.initState();
    instance.eCurrency.value = currency.currencyName;
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          leading: BackButton(
            color: TColors.light,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Sell',
            style: textTheme.titleLarge?.copyWith(color: TColors.light),
          ),
        ),
        body: SellBody(coinData: coinData, currency: currency),
      ),
    );
  }
}
