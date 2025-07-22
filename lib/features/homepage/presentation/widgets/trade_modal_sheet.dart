import '../../../../core/shared/middleware/auth_guard.dart';
import 'widgets.dart';

class TradeModalSheet extends StatelessWidget {
  const TradeModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return AnimatedGradientColoring(
      padding: 8,
      endColor: TColors.primary,
      startColor: TColors.secondary,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(Get.context!).height / 3,
        child: ScrollableWidget(
          padding: 8,
          children: [
            Text(
              'Trade',
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(color: TColors.light),
            ),
            const SizedBox(height: TSizes.spaceBtwSections / 2),
            TradeTile(
              title: 'Buy',
              onTap: () => Get.toNamed(Routers.actionBuy),
              subtitle: 'Add to your portfolio with a buy order',
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 3),
            TradeTile(
              onTap: () {
                Get.find<AuthGuard>().checkKycAndExecute(() {});
              },
              title: 'Sell',
              subtitle: 'Cash out or swap your crypto assets.',
            ),
          ],
        ),
      ),
    );
  }
}
