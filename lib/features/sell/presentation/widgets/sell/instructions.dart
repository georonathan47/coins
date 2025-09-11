import '../../../../../core/shared/data/currency_format.dart';
import '../widgets.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key, required this.currency});

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<SellController>(
      builder: (controller) {
        return Card(
          child: Form(
            key: controller.formKeys[2],
            child: ScrollableWidget(
              padding: 8,
              children: [
                RichText(
                  text: TextSpan(
                    text: '1• ',
                    style: textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Please transfer exactly ',
                        style: textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: CurrencyFormatter.dollar(
                          controller.calcResponse.value.usdTotal ?? 0,
                        ),
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' to the following address:',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 6,
                        child: SelectableText(
                          currency.address,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                          style: textTheme.bodyLarge!.copyWith(
                            color: TColors.accent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: IconButton.filledTonal(
                          icon: const Icon(Iconsax.copy),
                          style: IconButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: TColors.secondary,
                          ),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: currency.address),
                            );
                            THelperFunctions.showSnackBar(
                              title: 'Copied',
                              bgColor: TColors.success,
                              message: 'Address copied to clipboard',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '2• ',
                    style: textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text:
                            'Once sent, allow some time for the transaction to be confirmed on the blockchain.',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '3• ',
                    style: textTheme.bodyLarge,
                    children: [
                      TextSpan(text: 'Click ', style: textTheme.bodyLarge),
                      TextSpan(
                        text: '“I have transferred funds” ',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'button below to complete your transaction.',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
