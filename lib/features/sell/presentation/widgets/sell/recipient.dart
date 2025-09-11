import '../widgets.dart';

class Recipient extends StatelessWidget {
  const Recipient({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<SellController>(
      builder: (controller) {
        return Card(
          child: ScrollableWidget(
            children: [
              Text(
                'Select where funds should be transferred upon successful transaction.',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              // Add recipient fields here
              SizedBox(
                height: Get.height / 5,
                child: ScrollableWidget(
                  padding: 0,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ...controller.userPaymentDetails.map(
                      (paymentDetail) => Obx(
                        () => Card(
                          surfaceTintColor: Colors.white54,
                          child: RadioListTile.adaptive(
                            value: paymentDetail,
                            activeColor: TColors.secondary,
                            selectedTileColor: TColors.secondary,
                            useCupertinoCheckmarkStyle: GetPlatform.isIOS,
                            groupValue: controller.selectedRecipient.value,
                            onChanged: (value) =>
                                controller.setSelectedRecipient(value!),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  paymentDetail.nameOnAccount,
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  paymentDetail.accountNumber,
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    paymentDetail.bankName,
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    paymentDetail.paymentMode.replaceAll(
                                      '_',
                                      " ",
                                    ),
                                    style: textTheme.bodySmall?.copyWith(
                                      color: TColors.accent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            visualDensity: const VisualDensity(
                              vertical: VisualDensity.minimumDensity,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Add more recipient options as needed
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[500])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[500])),
                ],
              ),
              // const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'To transfer funds to a different account after a successful transaction, add the account by clicking the button below.',
                style: textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  THelperFunctions.showSnackBar(
                    title: 'Coming Soon...',
                    bgColor: TColors.info,
                    message: 'This feature is not yet implemented.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Add 3rd Party Account',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
