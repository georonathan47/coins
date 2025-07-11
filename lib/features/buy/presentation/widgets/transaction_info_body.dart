import 'widgets.dart';

class TransactionInfoBody extends StatefulWidget {
  const TransactionInfoBody({super.key});

  @override
  State<TransactionInfoBody> createState() => TransactionInfoBodyState();
}

class TransactionInfoBodyState extends State<TransactionInfoBody> {
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScrollableWidget(
        padding: 12,
        physics: const BouncingScrollPhysics(),
        children: [
          RichText(
            text: TextSpan(
              text:
                  'Please provide the information about the transfer below. Once you are done, click ',
              style: textTheme.titleSmall?.copyWith(fontSize: 18),
              children: [
                TextSpan(
                  text: "'Confirm Transaction'.",
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          DeclarationWidget(),
          Card(
            elevation: 2,
            child: ScrollableWidget(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ETextFormField(
                  icon: Iconsax.user,
                  labelText: 'Name on Account',
                  controller: instance.name.value,
                  keyboardType: TextInputType.name,
                  hintText: 'Enter name on account',
                ),
                ETextFormField(
                  icon: Iconsax.mobile,
                  labelText: 'Mobile Number',
                  hintText: 'Enter mobile number',
                  keyboardType: TextInputType.phone,
                  controller: instance.number.value,
                ),
                DropdownButtonFormField(
                  items: instance.paymentMode.contains('BANK')
                      ? instance.banks
                            .asMap()
                            .entries
                            .map(
                              (entry) => DropdownMenuItem<String>(
                                value: '${entry.key}_${entry.value.bankName}',
                                child: Text(
                                  entry.value.bankName,
                                  style: textTheme.bodyLarge,
                                ),
                                onTap: () {
                                  instance.order.value.copyWith(
                                    bankName: entry.value.bankName,
                                  );
                                },
                              ),
                            )
                            .toList()
                      : instance.momo
                            .asMap()
                            .entries
                            .map(
                              (entry) => DropdownMenuItem<String>(
                                value: '${entry.key}_${entry.value.bankName}',
                                child: Text(
                                  entry.value.bankName,
                                  style: textTheme.bodyLarge,
                                ),
                                onTap: () {
                                  instance.order.value.copyWith(
                                    bankName: entry.value.bankName,
                                  );
                                },
                              ),
                            )
                            .toList(),
                  onChanged: (value) {
                    instance.order.value.copyWith(bankName: value!);
                  },
                  isExpanded: true,
                  isDense: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Iconsax.wallet_2,
                      color: TColors.accent,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    hint: Text(
                      instance.paymentMode.contains('BANK')
                          ? 'Select Bank'
                          : 'Select Network',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
                ETextFormField(
                  icon: Iconsax.wallet_2,
                  labelText: 'Transaction ID',
                  hintText: 'Enter Transaction ID',
                  keyboardType: TextInputType.number,
                  controller: instance.transactionId.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
