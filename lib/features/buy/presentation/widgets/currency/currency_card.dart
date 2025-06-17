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
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currency.name, style: textTheme.titleMedium),
                      Text(
                        TFormatter.formatDollar(double.parse(currency.price)),
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currency.symbol, style: textTheme.titleSmall),
                      Text(
                        currency.percentageChange,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: currency.percentageChange.startsWith('-')
                              ? TColors.error
                              : TColors.secondary,
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
