import 'widgets.dart';

class NoPayAccountWidget extends StatelessWidget {
  const NoPayAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<PayAccountsController>(
      builder: (instance) {
        return ScrollableWidget(
          children: [
            Center(
              child: SvgPicture.asset(
                SvgAssets.noPayAccount,
                height: Get.height / 2.5,
              ),
            ),
            Center(
              child: Text('No PayAccounts Added', style: textTheme.titleLarge),
            ),
            Text(
              'Begin by adding a PayAccount to start managing your finances. Click the button below to add a new wallet',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => instance.openAccount(),
              child: Text('Add PayAccount'),
            ),
          ],
        );
      },
    );
  }
}
