import '../../../../core/shared/constants/svg_assets.dart';
import '../widgets/widgets.dart';

class SellSuccessPage extends StatelessWidget {
  const SellSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: ScrollableWidget(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(SvgAssets.success, fit: BoxFit.contain),
            ),
            Text(
              'Success',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall!.copyWith(
                letterSpacing: .5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Your sell order has been successfully created. Kindly await processing.',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 18,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routers.index),
              child: Text(
                'Go To Homepage',
                style: textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            OutlinedButton(
              onPressed: () => Get.offAllNamed(Routers.sellHistory),
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
