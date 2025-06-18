import '../widgets/widgets.dart';

class PaymentSelectionPage extends StatefulWidget {
  const PaymentSelectionPage({super.key});

  @override
  State<PaymentSelectionPage> createState() => PaymentSelectionPageState();
}

class PaymentSelectionPageState extends State<PaymentSelectionPage> {
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          leading: BackButton(color: TColors.light),
          title: Text(
            'Payment Details',
            style: textTheme.titleLarge?.copyWith(color: TColors.light),
          ),
        ),
        body: PaymentSelectionBody(),
      ),
    );
  }
}
