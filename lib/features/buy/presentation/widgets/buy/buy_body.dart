import 'package:flutter/services.dart';

import '../../../../../core/utils/logger.dart';
import '../../controller/buy_controller.dart';
import '../widgets.dart';

class BuyBody extends StatefulWidget {
  const BuyBody({super.key});

  @override
  State<BuyBody> createState() => _BuyBodyState();
}

class _BuyBodyState extends State<BuyBody> {
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
            // value: instance.network.value,
            items: [
              DropdownMenuItem(value: 'REGULAR', child: Text('Regular')),
              DropdownMenuItem(value: 'PRIORITY', child: Text('Priority')),
            ],
            onChanged: (value) {
              instance.network.value = value!;
              TLoggerHelper.logEvent(
                instance.network.value,
                eventName: 'Network Fee Type',
              );
            },
            isDense: true,
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              labelText: 'Network Fee Type',
              hintStyle: textTheme.bodyLarge,
              labelStyle: textTheme.bodyLarge,
              hintText: 'Select Network Fee Type',
              prefixIcon: const Icon(Iconsax.money),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          const LocalRate(),
          Icon(
            Icons.swap_horiz,
            color: TColors.accent,
            size: TSizes.iconLg * 1.5,
          ),
          const DollarRate(),
          const SizedBox(height: TSizes.spaceBtwItems),
          Card(
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
                        '\$56,750.98',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
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
                        '\$1,000.00',
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          fontSize: 18,
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
                        'GHS 150,000.00',
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TextFormField(
                    maxLength: 32,
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
