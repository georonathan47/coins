import 'package:flutter/services.dart';

import '../../../../../core/utils/logger.dart';
import '../../../data/models/currency.dart';
import '../widgets.dart';

class BuyBody extends StatefulWidget {
  const BuyBody({super.key, required this.coinData, required this.currency});
  final CoinData coinData;
  final Currency currency;

  @override
  State<BuyBody> createState() => BuyBodyState();
}

class BuyBodyState extends State<BuyBody> {
  final textTheme = Get.textTheme;
  final formKey = GlobalKey<FormState>();
  final instance = BuyController.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: ScrollableWidget(
        physics: const BouncingScrollPhysics(),
        children: [
          DropdownButtonFormField(
            isDense: true,
            items: [
              DropdownMenuItem(value: 'REGULAR', child: Text('Regular')),
              DropdownMenuItem(value: 'PRIORITY', child: Text('Express')),
            ],
            onChanged: (value) {
              instance.network.value = value!;
              TLoggerHelper.logEvent(
                instance.network.value,
                eventName: 'Network Fee Type',
              );
            },
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              labelText: 'Network Fee Type',
              hintStyle: textTheme.bodyLarge,
              labelStyle: textTheme.bodyLarge,
              hintText: 'Select Network Fee Type',
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
          Stack(
            fit: StackFit.loose,
            children: [
              LocalRate(coinData: widget.coinData, currency: widget.currency),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: widget.coinData.icon.contains('.svg')
                          ? SvgPicture.network(
                              widget.coinData.icon,
                              fit: BoxFit.contain,
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.coinData.icon,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.swap_horiz,
            color: TColors.accent,
            size: TSizes.iconLg * 1.5,
          ),
          const DollarRate(),
          const SizedBox(height: TSizes.spaceBtwItems),
          Obx(
            () => Card(
              elevation: 4,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                height: size.height / 2.75,
                child: ScrollableWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Network Fee (USD)',
                          style: textTheme.titleMedium?.copyWith(fontSize: 18),
                        ),
                        Text(
                          instance.network.value == 'REGULAR'
                              ? TFormatter.formatDollar(
                                  instance
                                          .calcResponse
                                          .value
                                          .regularNetworkFee ??
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    TextButton.icon(
                      onPressed: () {},
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        'Totals',
                        style: textTheme.titleMedium?.copyWith(fontSize: 18),
                      ),
                      icon: const Icon(Iconsax.info_circle),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount to Pay (USD)',
                          style: textTheme.titleMedium?.copyWith(fontSize: 18),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount to Pay (GHS)',
                          style: textTheme.titleMedium?.copyWith(fontSize: 18),
                        ),
                        Text(
                          TFormatter.formatCurrency(
                            instance.calcResponse.value.amountLocalCurrency ??
                                0,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    TextFormField(
                      maxLength: 32,
                      controller: instance.wallet.value,
                      validator: TValidator.validateWalletAddress,
                      maxLengthEnforcement:
                          MaxLengthEnforcement.truncateAfterCompositionEnds,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        labelText: 'Enter Wallet Address',
                        hintText: 'Enter Wallet Address',
                        prefixIcon: const Icon(Iconsax.wallet),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          ElevatedButton.icon(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Get.toNamed(Routers.buySummary);
              }
            },
            iconAlignment: IconAlignment.end,
            icon: Icon(Icons.chevron_right, size: TSizes.iconLg),
            label: Text(
              'Proceed',
              style: textTheme.titleMedium?.copyWith(color: TColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
