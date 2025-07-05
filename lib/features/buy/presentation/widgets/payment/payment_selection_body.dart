import '../../../domain/entities/payment_mode.dart';
import '../widgets.dart';

class PaymentSelectionBody extends StatefulWidget {
  const PaymentSelectionBody({super.key});

  @override
  State<PaymentSelectionBody> createState() => PaymentSelectionBodyState();
}

class PaymentSelectionBodyState extends State<PaymentSelectionBody> {
  final dark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;
  final prefAcc = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      physics: const BouncingScrollPhysics(),
      children: [
        Text(
          'Select payment mode and account'.capitalize!,
          style: textTheme.titleMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
                  instance.calcResponse.value.totalAmountLocalCurrency ?? 0,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' to it.'),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        DropdownButtonFormField<PaymentMode>(
          isDense: true,
          isExpanded: true,
          items: instance.payModes
              .map(
                (mode) => DropdownMenuItem(
                  value: mode,
                  onTap: () async {
                    setState(() {
                      prefAcc.value = mode.paymentMode;
                      instance.paymentMode.value = mode.paymentMode;
                      instance.paymentType.value = mode.paymentType;
                    });
                    if (mode.paymentType.contains('BANK')) {
                      await instance.fetchBanks();
                    }
                  },
                  child: Text(mode.paymentMode, style: textTheme.bodyLarge),
                ),
              )
              .toList(),

          onChanged: (value) {}, // onChanged: (value) async {
          //   setState(() {
          //     instance.paymentMode.value = value!.paymentMode;
          //     instance.paymentType.value = value.paymentType;
          //   });
          //   if (value!.paymentType.contains('BANK')) {
          //     await instance.fetchBanks();
          //   }
          // },
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            labelText: 'Preferred Payment Mode',
            prefixIcon: const Icon(Iconsax.money),
            contentPadding: const EdgeInsets.all(16),
            hintStyle: textTheme.bodyLarge?.copyWith(fontSize: 18),
            labelStyle: textTheme.bodyLarge?.copyWith(fontSize: 16),
            hint: Text('Select payment mode', style: textTheme.bodyLarge),
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
        ValueListenableBuilder(
          valueListenable: prefAcc,
          builder: (context, value, child) {
            return DropdownButtonFormField(
              isDense: true,
              items: value.contains('BANK')
                  ? instance.banks
                        .map(
                          (mode) => DropdownMenuItem(
                            value: mode,
                            child: Text(
                              mode.bankName,
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        )
                        .toList()
                  : instance.momo
                        .map(
                          (mode) => DropdownMenuItem(
                            value: mode,
                            child: Text(mode.name, style: textTheme.bodyLarge),
                          ),
                        )
                        .toList(),
              onChanged: (value) {
                // setState(() {
                //   instance.paymentMode.value = value!.paymentMode;
                //   instance.paymentType.value = value.paymentType;
                // });
              },
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                labelText: 'Preferred Account',
                labelStyle: textTheme.bodyMedium,
                prefixIcon: const Icon(Iconsax.money),
                contentPadding: const EdgeInsets.all(16),
                hint: Text(
                  'Select preferred account',
                  style: textTheme.bodyLarge,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            );
          },
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Divider(height: 1, color: TColors.accent),
        const SizedBox(height: TSizes.spaceBtwItems),
        Visibility(
          visible:
              instance.order.value.localCurrencyTotal != null &&
              instance.order.value.localCurrencyTotal! > 2500,
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: Get.height / 2,
              padding: const EdgeInsets.all(8),
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
