
import '../../../../core/constants/svg_assets.dart';
import '../widgets/widgets.dart';

class BuySuccessPage extends StatelessWidget {
  const BuySuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(),
        body: ScrollableWidget(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(SvgAssets.success, fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),
            Text(
              'Success',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium!.copyWith(
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Your buy order has been successfully created. Kindly await processing.',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 18,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            ElevatedButton(
              onPressed: () => Get.offNamed(Routers.buy),
              child: Text(
                'Buy More Crypto',
                style: textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () => Get.offNamed(Routers.buyHistory),
              child: Text(
                'View Order History',
                style: textTheme.titleLarge?.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
