import '../widgets.dart';

class SellBody extends StatefulWidget {
  const SellBody({super.key, required this.coinData, required this.currency});
  final CoinData coinData;
  final Currency currency;

  @override
  State<SellBody> createState() => SellBodyState();
}

class SellBodyState extends State<SellBody> {
  final textTheme = Get.textTheme;
  final instance = SellController.instance;

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      padding: 8,
      physics: const BouncingScrollPhysics(),
      children: [
        Stack(
          fit: StackFit.loose,
          children: [
            SellLocalRate(coinData: widget.coinData, currency: widget.currency),
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
        Obx(
          () => Card(
            elevation: 4,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              height: Get.height / 4.75,
              child: ScrollableWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transfer Charges', style: textTheme.bodyLarge),
                      Text(
                        '0%',
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: .75, color: TColors.accent),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount (USD)', style: textTheme.bodyLarge),
                      Text(
                        TFormatter.formatDollar(
                          instance.calcResponse.value.amountStandardCurrency ??
                              0,
                        ),
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount to Receive (GHS)',
                        style: textTheme.bodyLarge,
                      ),
                      Text(
                        TFormatter.formatCurrency(
                          instance.calcResponse.value.amountLocalCurrency ?? 0,
                        ),
                        style: textTheme.bodyLarge?.copyWith(
                          height: 1.5,
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

        const SizedBox(height: TSizes.spaceBtwSections),
        ElevatedButton.icon(
          onPressed: () {
            if (instance.local.value.text.isEmpty) {
              THelperFunctions.showSnackBar(
                title: 'Info',
                bgColor: TColors.info,
                message: 'Please enter an amount to sell',
              );
              return;
            }
            Get.toNamed(Routers.sellPay, arguments: widget.currency);
          },
          iconAlignment: IconAlignment.end,
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          label: Text(
            'Continue',
            style: textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
