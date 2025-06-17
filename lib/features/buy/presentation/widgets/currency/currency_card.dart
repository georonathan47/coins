import 'package:cached_network_image/cached_network_image.dart';

import '../widgets.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({super.key, required this.currency});
  final CoinData currency;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipOval(
              child: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: currency.icon,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currency.name, style: textTheme.titleLarge),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text(currency.symbol, style: textTheme.titleSmall),
                      Text(
                        currency.percentageChange,
                        style: textTheme.titleMedium?.copyWith(
                          color: double.parse(currency.percentageChange) >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text(
                        TFormatter.formatDollar(double.parse(currency.price)),
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: Sparkline(
                            useCubicSmoothing: true,
                            fillMode: FillMode.below,
                            cubicSmoothingFactor: 0.2,
                            data: currency.sparkline,
                            lineColor: Get.isDarkMode
                                ? Colors.white
                                : TColors.primary,
                            fillGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(
                                  int.parse(
                                    currency.color.replaceAll('#', '0xFF'),
                                  ),
                                ),
                                Color(
                                  int.parse(
                                    currency.color.replaceAll('#', '0xCF'),
                                  ),
                                ),
                                Color(
                                  int.parse(
                                    currency.color.replaceAll('#', '0xAF'),
                                  ),
                                ),
                                Color(
                                  int.parse(
                                    currency.color.replaceAll('#', '0x26'),
                                  ),
                                ),
                                Color(
                                  int.parse(
                                    currency.color.replaceAll('#', '0x1A'),
                                  ),
                                ),
                                Color(
                                  int.parse(
                                    currency.color.replaceAll('#', '0x0D'),
                                  ),
                                ),
                              ],
                            ),
                            gridLineColor: Colors.black.withOpacity(0.1),
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
