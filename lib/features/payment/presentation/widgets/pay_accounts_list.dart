import 'widgets.dart';

class PayAccountsList extends StatelessWidget {
  const PayAccountsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayAccountsController>(
      builder: (instance) {
        return ScrollableWidget(
          children: [
            SwippablePayAccountCard(
              payAccounts: instance.userPaymentDetails,
            ),
            
          ],
        );
      },
    );
  }
}
