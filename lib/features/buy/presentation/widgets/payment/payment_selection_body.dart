import '../widgets.dart';

class PaymentSelectionBody extends StatefulWidget {
  const PaymentSelectionBody({super.key});

  @override
  State<PaymentSelectionBody> createState() => PaymentSelectionBodyState();
}

class PaymentSelectionBodyState extends State<PaymentSelectionBody> {
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      physics: const BouncingScrollPhysics(),
      children: [
        Text(
          'Select payment mode and account'.capitalize!,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text:
                    'Select your preferred payment mode and the associated platform account and transfer an amount of ',
              ),
              TextSpan(
                text: TFormatter.formatCurrency(
                  instance.order.value.localCurrencyTotal ?? 0.0,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' to it.'),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        DropdownButtonFormField(
          isDense: true,
          items: [
            DropdownMenuItem(
              value: 'BANK_TRANSFER',
              child: Text('Bank', style: textTheme.titleMedium),
            ),
            DropdownMenuItem(
              value: 'GHQR',
              child: Text('GhQR All Networks', style: textTheme.titleMedium),
            ),
            DropdownMenuItem(
              value: 'MOBILE_MONEY',
              child: Text('USSD Mobile Money', style: textTheme.titleMedium),
            ),
          ],
          onChanged: (value) {},
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            hintStyle: textTheme.bodyMedium,
            labelStyle: textTheme.bodyMedium,
            hintText: 'Select a payment mode',
            labelText: 'Preferred Payment Mode',
            prefixIcon: const Icon(Iconsax.money),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          'Select a preferred account for this trade'.capitalize!,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        DropdownButtonFormField(
          isDense: true,
          items: [
            DropdownMenuItem(
              value: 'MTN',
              child: Text('MTN', style: textTheme.titleMedium),
            ),
            DropdownMenuItem(
              value: 'ATMONEY',
              child: Text('ATMoney GhQR', style: textTheme.titleMedium),
            ),
            DropdownMenuItem(
              value: 'TELECEL',
              child: Text('Telecel', style: textTheme.titleMedium),
            ),
          ],
          onChanged: (value) {},
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            labelText: 'Preferred Account',
            hintStyle: textTheme.bodyMedium,
            labelStyle: textTheme.bodyMedium,
            prefixIcon: const Icon(Iconsax.money),
            hintText: 'Select a preferred account',
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        const Divider(height: 1),
        const SizedBox(height: TSizes.spaceBtwItems),
        Visibility(
          visible:
              instance.order.value.localCurrencyTotal != null &&
              instance.order.value.localCurrencyTotal! > 2500,
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                color: TColors.softGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: Get.height / 2,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Note: Ensure you have sufficient funds in your selected account before proceeding with the payment.',
                style: textTheme.bodyMedium?.copyWith(color: TColors.accent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
