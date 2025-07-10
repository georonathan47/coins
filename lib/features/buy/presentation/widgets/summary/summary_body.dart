import '../widgets.dart';

class BuySummaryBody extends StatelessWidget {
  const BuySummaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final instance = BuyController.instance;
    final size = MediaQuery.of(context).size;
    return ScrollableWidget(
      padding: 8,
      children: [
        Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: TColors.accent.withOpacity(.2),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            height: size.height / 15,
            child: Center(
              child: Text(
                'Please note that this order expires in 15 minutes!',
                style: textTheme.bodyLarge?.copyWith(
                  color: TColors.accent,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        Card(
          elevation: 4,
          child: Container(
            decoration: const BoxDecoration(
              // color: TColors.softGrey,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            height: size.height / 2,
            child: Obx(
              () => ScrollableWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Type', style: textTheme.titleSmall),
                      Text(
                        'BUY ORDER'.capitalize!,
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('eCurrency', style: textTheme.titleSmall),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Network Fee (USD)', style: textTheme.titleSmall),
                      Text(
                        instance.network.value == 'REGULAR'
                            ? TFormatter.formatDollar(
                                instance.calcResponse.value.regularNetworkFee ??
                                    0,
                              )
                            : TFormatter.formatDollar(
                                instance
                                        .calcResponse
                                        .value
                                        .priorityNetworkFee ??
                                    0,
                              ),
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date Created', style: textTheme.titleSmall),
                      Text(
                        THelperFunctions.getFormattedDate(DateTime.now()),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Status', style: textTheme.titleSmall),
                      Text(
                        'Payment Pending'.capitalize!,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount To Buy (USD)', style: textTheme.titleSmall),
                      Text(
                        TFormatter.formatDollar(
                          instance.calcResponse.value.amountStandardCurrency ??
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
                  const Divider(thickness: 2),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Totals (Includes all fees)',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount To Pay (USD)', style: textTheme.titleSmall),
                      Text(
                        TFormatter.formatDollar(
                          instance.calcResponse.value.usdTotal ?? 0,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount To Pay (GHS)', style: textTheme.titleSmall),
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
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 2),
        ElevatedButton.icon(
          iconAlignment: IconAlignment.end,
          icon: Icon(Icons.chevron_right, size: TSizes.iconLg),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
            await instance.fetchPaymentModes();
          },
          label: Text(
            'Confirm Buy',
            style: textTheme.titleMedium?.copyWith(color: TColors.white),
          ),
        ),
      ],
    );
  }
}
