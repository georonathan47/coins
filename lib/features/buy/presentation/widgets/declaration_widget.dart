import 'widgets.dart';

class DeclarationWidget extends StatefulWidget {
  const DeclarationWidget({super.key});

  @override
  State<DeclarationWidget> createState() => _DeclarationWidgetState();
}

class _DeclarationWidgetState extends State<DeclarationWidget> {
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: TColors.accent.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        height: Get.height / 8,
        child: Center(
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'I, ',
              style: textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: instance.currentUser.value.fullName,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ', hereby confirm that I have made a transfer of ',
                  style: textTheme.bodyLarge,
                ),
                TextSpan(
                  text: TFormatter.formatCurrency(
                    instance.calcResponse.value.totalAmountLocalCurrency!,
                  ),
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' to ', style: textTheme.bodyLarge),
                TextSpan(
                  text: 'NICS IT & SOLUTIONS ',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: 'on ', style: textTheme.bodyLarge),
                TextSpan(
                  text: TFormatter.formatDate(DateTime.now()),
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '. The transaction details have been provided below.',
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
