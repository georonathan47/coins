import '../widgets/pay_accounts_list.dart';
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
        body: GetBuilder<PayAccountsController>(
          builder: (instance) {
            if (instance.userPaymentDetails.isEmpty) {
              return const NoPayAccountWidget();
            }
            return const PayAccountsList();
          },
        ),
      ),
    );
  }
}

// class PayAccountsListWidget extends StatelessWidget {
//   final List<UserPaymentDetail> userPaymentDetails;
//   final VoidCallback onAddAccount;

//   const PayAccountsListWidget({
//     required this.userPaymentDetails,
//     required this.onAddAccount,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ScrollableWidget(
//       padding: 8,
//       children: [
//         ...userPaymentDetails.map(
//           (paymentDetail) => PaymentDetailCard(paymentDetail: paymentDetail),
//         ),
//         SizedBox(height: TSizes.spaceBtwItems),
//         ElevatedButton(
//           onPressed: onAddAccount,
//           child: Text('Add PayAccount'),
//         ),
//       ],
//     );
//   }
// }
