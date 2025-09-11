import '../widgets.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({super.key, required this.coinData});
  final CoinData coinData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: CircleAvatar(
                child: coinData.icon.contains('.svg')
                    ? SvgPicture.network(
                        coinData.icon,
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                        imageUrl: coinData.icon,
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coinData.name, style: textTheme.titleMedium),
                      Text(
                        TFormatter.formatDollar(double.parse(coinData.price)),
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          final result = await Get.find<DashboardController>()
                              .fetchCurrencies();
                          final currency = result.firstWhere(
                            (element) => element.currencyName == coinData.name,
                          );
                          Get.back();
                          Get.toNamed(
                            Routers.buy,
                            arguments: {
                              'coinData': coinData,
                              'currency': currency,
                            },
                          );
                        },
                        icon: Icon(Iconsax.buy_crypto, color: Colors.white),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          'Buy',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coinData.symbol, style: textTheme.titleSmall),
                      Text(
                        coinData.percentageChange,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: coinData.percentageChange.startsWith('-')
                              ? TColors.error
                              : TColors.secondary,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          final result = await Get.find<DashboardController>()
                              .fetchCurrencies();
                          final currency = result.firstWhere(
                            (element) => element.currencyName == coinData.name,
                          );
                          Get.back();
                          Get.toNamed(
                            Routers.sell,
                            arguments: {
                              'coinData': coinData,
                              'currency': currency,
                            },
                          );
                        },
                        icon: Icon(Iconsax.trade, color: Colors.white),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          'Sell',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.error,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
