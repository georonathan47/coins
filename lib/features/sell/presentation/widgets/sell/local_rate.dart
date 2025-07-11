import '../widgets.dart';

class SellLocalRate extends StatefulWidget {
  const SellLocalRate({
    super.key,
    required this.coinData,
    required this.currency,
  });
  final CoinData coinData;
  final Currency currency;

  @override
  State<SellLocalRate> createState() => _SellLocalRateState();
}

class _SellLocalRateState extends State<SellLocalRate> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = SellController.instance;

  @override
  void dispose() {
    instance.network.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: TSizes.spaceBtwItems),
        Card(
          elevation: 4,
          child: AnimatedGradientColoring(
            padding: 0,
            endColor: Color(0xFF2C627A),
            startColor: Color(0xFF285062),
            child: Container(
              height: size.height * .15,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(TImages.overlay),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Text(
                          'Local Currency',
                          style: textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            letterSpacing: .75,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Center(
                        child: SizedBox(
                          width: size.width / 2,
                          child: EditableText(
                            focusNode: FocusNode(),
                            cursorColor: TColors.light,
                            controller: instance.local.value,
                            backgroundCursorColor: TColors.secondary,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            style: textTheme.titleLarge!.copyWith(
                              letterSpacing: 1.75,
                              color: Colors.white,
                            ),
                            onChanged: (amount) {
                              final amount = instance.local.value.text.trim();
                              final amountIsValid =
                                  amount.isNotEmpty &&
                                  double.tryParse(amount) != null &&
                                  double.parse(amount) >= 10.0;
                              if (amountIsValid) {
                                THelperFunctions.debounce(() async {
                                  if (instance.network.value.isEmpty) {
                                    THelperFunctions.showSnackBar(
                                      bgColor: TColors.error,
                                      title: 'Validation Error!',
                                      message:
                                          'Please select network fee type.',
                                    );
                                    return;
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (_) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                  instance.currencyId.value =
                                      widget.currency.id;
                                  await instance.calculate();
                                });
                              } else {
                                THelperFunctions.showSnackBar(
                                  bgColor: TColors.error,
                                  title: 'Validation Error!',
                                  message:
                                      'Please enter a valid amount greater than or equal to \$ 10.00',
                                );
                                return;
                              }
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: IntrinsicHeight(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  '1 ${widget.coinData.symbol} = ${TFormatter.formatDollar(double.parse(widget.coinData.price))}',
                              style: textTheme.bodyLarge!.copyWith(
                                letterSpacing: .75,
                                color: TColors.light,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
