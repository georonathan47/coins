import '../../../../core/shared/constants/svg_assets.dart';
import '../widgets/widgets.dart';

class PayAccountsWelcomePage extends StatelessWidget {
  const PayAccountsWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PayAccounts',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? TColors.white : TColors.primary,
            ),
          ),
          centerTitle: true,
        ),
        body: ScrollableWidget(
          children: [
            Center(
              child: SvgPicture.asset(
                SvgAssets.noPayAccount,
                height: Get.height / 2.5,
              ),
            ),
            Center(
              child: Text('No PayAccounts added.', style: textTheme.titleLarge),
            ),
            Text(
              'Begin by adding a PayAccount to start managing your finances. Click the button below to add a new wallet',
              style: textTheme.bodyLarge,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Add PayAccount')),
          ],
        ),
      ),
    );
  }
}
