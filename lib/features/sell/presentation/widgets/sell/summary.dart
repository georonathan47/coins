import '../widgets.dart';

class SellSummary extends StatefulWidget {
  const SellSummary({super.key, required this.currency});
  final Currency currency;

  @override
  State<SellSummary> createState() => SellSummaryState();
}

class SellSummaryState extends State<SellSummary> {
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellController>(
      builder: (instance) {
        return SizedBox(
          height: Get.height / 2.5,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(4),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: TColors.accent.withOpacity(.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        height: Get.height / 10,
                        child: Center(
                          child: Text(
                            'Please take some time to double check your order summary before you proceed',
                            style: textTheme.bodyLarge?.copyWith(
                              color: TColors.accent,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          // color: TColors.softGrey,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order Type',
                                    style: textTheme.titleSmall,
                                  ),
                                  Text(
                                    'SELL ORDER'.capitalize!,
                                    style: textTheme.bodyLarge?.copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'eCurrency',
                                    style: textTheme.titleSmall,
                                  ),
                                  Text(
                                    instance.eCurrency.value.capitalize!,
                                    style: textTheme.bodyLarge?.copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Transaction Fee',
                                    style: textTheme.titleSmall,
                                  ),
                                  Text(
                                    '0%',
                                    style: textTheme.bodyLarge?.copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date Created',
                                    style: textTheme.titleSmall,
                                  ),
                                  Text(
                                    THelperFunctions.getFormattedDate(
                                      DateTime.now(),
                                    ),
                                    style: textTheme.bodyLarge?.copyWith(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount To Send (USD)',
                                    style: textTheme.titleSmall,
                                  ),
                                  Text(
                                    TFormatter.formatDollar(
                                      instance
                                              .calcResponse
                                              .value
                                              .amountStandardCurrency ??
                                          0,
                                    ),
                                    style: textTheme.bodyLarge?.copyWith(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount To Receive',
                                    style: textTheme.titleSmall,
                                  ),
                                  Text(
                                    TFormatter.formatCurrency(
                                      instance
                                              .calcResponse
                                              .value
                                              .totalAmountLocalCurrency ??
                                          0,
                                    ),
                                    style: textTheme.bodyLarge?.copyWith(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              const Divider(thickness: .75),
                              const SizedBox(height: TSizes.spaceBtwItems / 2),
                              Text(
                                'Important!',
                                style: textTheme.bodyLarge?.copyWith(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems / 2),
                              RichText(
                                text: TextSpan(
                                  text: 'Risk Warning: ',
                                  style: textTheme.bodyLarge?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: TTexts.riskWarning,
                                      style: textTheme.titleSmall,
                                    ),
                                    TextSpan(
                                      text: TFormatter.formatDollar(
                                        instance
                                                .calcResponse
                                                .value
                                                .amountStandardCurrency ??
                                            0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              RichText(
                                text: TextSpan(
                                  text: 'Risk Warning: ',
                                  style: textTheme.bodyLarge?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "By sending the ${widget.currency.currencyName.toUpperCase()}, you agree that you've been informed that you'll be paid for the USD value at time of transaction (live rates on ${widget.currency.currencyName.toUpperCase()} explorer) and also after we have received at least 1 - 3 confirmations (for value below 999 USD) or 3 - 6 confirmations (for value above 1000 USD) from the ${widget.currency.currencyName.toUpperCase()} network - eBitcoinics.com do NOT determine how fast your transaction gets confirmed on the ${widget.currency.currencyName.toUpperCase()} network, its all done by miners! Risk warning: Cryptocurrency trading is subject to high market risk. eBitcoinics.com will make the best efforts to choose high-quality coins, but will not be responsible for your trading losses. Please trade with caution and we also encourage you to be aware of phishing sites and always make sure you are visiting the official eBitcoinics.com website when entering sensitive data!",
                                      style: textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
