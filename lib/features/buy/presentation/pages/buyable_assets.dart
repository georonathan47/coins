import '../widgets/buy/currencies_grid.dart';
import '../widgets/widgets.dart';

class BuyableAssets extends StatefulWidget {
  const BuyableAssets({super.key});

  @override
  State<BuyableAssets> createState() => BuyableAssetsState();
}

class BuyableAssetsState extends State<BuyableAssets> {
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;
  final coinData = Get.arguments as CoinData;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          title: Text(
            'Currencies To Buy From',
            style: textTheme.titleLarge?.copyWith(color: TColors.light),
          ),
        ),
        body: ScrollableWidget(
          padding: 16,
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Select a currency to buy from the list below.',
              style: textTheme.titleMedium?.copyWith(
                fontSize: 18,
                letterSpacing: .5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            // const BuyableAssetsList(),
            CurrenciesGrid(coinData: coinData),
          ],
        ),
      ),
    );
  }
}
