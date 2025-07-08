import '../../../domain/entities/payment_mode.dart';
import '../widgets.dart';

class PaymentSelectionBody extends StatefulWidget {
  const PaymentSelectionBody({super.key});

  @override
  State<PaymentSelectionBody> createState() => _PaymentSelectionBodyState();
}

class _PaymentSelectionBodyState extends State<PaymentSelectionBody> {
  final dark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;
  final prefAcc = ValueNotifier<String>('');

  String? selectedAccount;

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      padding: 8,
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
        // DropdownButtonFormField<PaymentMode>(
        //   isDense: true,
        //   isExpanded: true,
        //   items: instance.payModes
        //       .map(
        //         (mode) => DropdownMenuItem(
        //           value: mode,
        //           onTap: () async {
        //             // setState(() {
        //             //   prefAcc.value = mode.paymentMode;
        //             //   instance.paymentMode.value = mode.paymentMode;
        //             prefAcc.value = '';
        //             instance.paymentMode.value = '';
        //             instance.paymentType.value = '';
        //             // });
        //             if (mode.paymentType.contains('BANK')) {
        //               await instance.fetchBanks();
        //             } else {
        //               await instance.fetchMomo();
        //             }
        //           },
        //           child: Text(mode.paymentMode, style: textTheme.bodyLarge),
        //         ),
        //       )
        //       .toList(),
        //   onChanged: (mode) {
        //     prefAcc.value = '';
        //     instance.paymentMode.value = '';
        //     instance.paymentType.value = '';
        //     setState(() {
        //       prefAcc.value = mode!.paymentMode;
        //       instance.paymentMode.value = mode.paymentMode;
        //       instance.paymentType.value = mode.paymentType;
        //     });
        //   },
        //   decoration: InputDecoration(
        //     filled: true,
        //     isDense: true,
        //     labelText: 'Preferred Payment Mode',
        //     prefixIcon: const Icon(Iconsax.money),
        //     contentPadding: const EdgeInsets.all(16),
        //     hintStyle: textTheme.bodyLarge?.copyWith(fontSize: 18),
        //     labelStyle: textTheme.bodyLarge?.copyWith(fontSize: 16),
        //     hint: Text('Select payment mode', style: textTheme.bodyLarge),
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ),
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        // ),
        // const SizedBox(height: TSizes.spaceBtwItems),
        // Text(
        //   'Select a preferred account for this trade'.capitalize!,
        //   style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: TSizes.spaceBtwItems),
        // ValueListenableBuilder(
        //   valueListenable: prefAcc,
        //   builder: (context, value, child) {
        //     return DropdownButtonFormField(
        //       isDense: true,
        //       value: selectedAccount,
        //       items: value.contains('BANK')
        //           ? instance.banks
        //                 .map(
        //                   (mode) => DropdownMenuItem<String>(
        //                     value: mode.bankName,
        //                     child: Text(
        //                       mode.bankName,
        //                       style: textTheme.bodyLarge,
        //                     ),
        //                   ),
        //                 )
        //                 .toList()
        //           : instance.momo
        //                 .map(
        //                   (mode) => DropdownMenuItem<String>(
        //                     value: mode.bankName,
        //                     child: Text(
        //                       mode.bankName,
        //                       style: textTheme.bodyLarge,
        //                     ),
        //                   ),
        //                 )
        //                 .toList(),
        //       onChanged: (value) async {
        //         setState(() {
        //           selectedAccount = value as String;
        //         });
        //         await instance.fetchPayDetails();
        //       },
        //       decoration: InputDecoration(
        //         filled: true,
        //         isDense: true,
        //         labelText: 'Preferred Account',
        //         labelStyle: textTheme.bodyMedium,
        //         prefixIcon: const Icon(Iconsax.money),
        //         contentPadding: const EdgeInsets.all(16),
        //         hint: Text(
        //           'Select preferred account',
        //           style: textTheme.bodyLarge,
        //         ),
        //         border: OutlineInputBorder(
        //           borderSide: BorderSide.none,
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //       ),
        //       autovalidateMode: AutovalidateMode.onUserInteraction,
        //     );
        //   },
        // ),
        DropdownButtonFormField<PaymentMode>(
          isDense: true,
          isExpanded: true,
          items: instance.payModes
              .map(
                (mode) => DropdownMenuItem(
                  value: mode,
                  onTap: () async {
                    // Reset values when payment mode changes
                    prefAcc.value = '';
                    instance.paymentMode.value = '';
                    instance.paymentType.value = '';
                    // Reset selected account to avoid stale values
                    selectedAccount = null;

                    if (mode.paymentType.contains('BANK')) {
                      await instance.fetchBanks();
                    } else {
                      await instance.fetchMomo();
                    }
                  },
                  child: Text(mode.paymentMode, style: textTheme.bodyLarge),
                ),
              )
              .toList(),
          onChanged: (mode) {
            prefAcc.value = '';
            instance.paymentMode.value = '';
            instance.paymentType.value = '';
            setState(() {
              prefAcc.value = mode!.paymentMode;
              instance.paymentMode.value = mode.paymentMode;
              instance.paymentType.value = mode.paymentType;
              // Reset selected account when payment mode changes
              selectedAccount = null;
            });
          },
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
            // Create unique dropdown items by using index or unique identifier
            final List<DropdownMenuItem<String>> dropdownItems =
                value.contains('BANK')
                ? instance.banks
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value:
                              '${entry.key}_${entry.value.bankName}', // Use index + name for uniqueness
                          child: Text(
                            entry.value.bankName,
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      )
                      .toList()
                : instance.momo
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value:
                              '${entry.key}_${entry.value.bankName}', // Use index + name for uniqueness
                          child: Text(
                            entry.value.bankName,
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      )
                      .toList();

            // Remove duplicates if any still exist
            final uniqueItems = <String, DropdownMenuItem<String>>{};
            for (final item in dropdownItems) {
              uniqueItems[item.value!] = item;
            }

            return DropdownButtonFormField<String>(
              isDense: true,
              value: selectedAccount,
              items: uniqueItems.values.toList(),
              onChanged: (value) async {
                setState(() {
                  selectedAccount = value;
                });
                await instance.fetchPayDetails();
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
        Obx(
          () => ExpandableCard(
            isExpanded: selectedAccount != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Details',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                ...instance.details
                    .where(
                      (detail) =>
                          detail.accountNumber ==
                              selectedAccount!.split('_')[1] ||
                          detail.bankName == selectedAccount!.split('_')[1],
                    )
                    .map(
                      (detail) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: textTheme.bodyLarge,
                              children: [
                                const TextSpan(
                                  text: 'Account Name: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${detail.accountName}\n'),
                                const TextSpan(
                                  text: 'Account Number: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${detail.accountNumber}\n'),
                                if (detail.bankName.isNotEmpty) ...[
                                  const TextSpan(
                                    text: 'Bank: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: detail.bankName),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Divider(height: 1, color: TColors.accent),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Text(
                            'Notes',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Text(
                            detail.note.capitalize!,
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
