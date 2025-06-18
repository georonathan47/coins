import '../widgets.dart';

class CurrencyGridCard extends StatelessWidget {
  const CurrencyGridCard({super.key, required this.currency});
  final CoinData currency;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: TColors.transparent,
                child: currency.icon.contains('.svg')
                    ? SvgPicture.network(
                        currency.icon,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: currency.icon,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              currency.name,
              style: textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Text(
              TFormatter.formatDollar(double.parse(currency.price)),
              style: textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currency.symbol, style: textTheme.titleSmall, maxLines: 1),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
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
    );
  }
}
