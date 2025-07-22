import '../widgets/widgets.dart';

class SellPaymentPage extends StatefulWidget {
  const SellPaymentPage({super.key});

  @override
  State<SellPaymentPage> createState() => SellPaymentPageState();
}

class SellPaymentPageState extends State<SellPaymentPage> {
  final textTheme = Get.textTheme;
  final currency = Get.arguments as Currency;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          title: Text(
            'Pay & Confirm',
            style: textTheme.titleMedium?.copyWith(color: TColors.light),
          ),
        ),
        body: PaymentStepper(currency: currency),
      ),
    );
  }
}
