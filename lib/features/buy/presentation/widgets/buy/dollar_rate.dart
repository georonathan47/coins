import '../../../data/models/currency.dart';
import '../widgets.dart';

class DollarRate extends StatefulWidget {
  const DollarRate({super.key, required this.coinData, required this.currency});
  final CoinData coinData;
  final Currency currency;

  @override
  State<DollarRate> createState() => _DollarRateState();
}

class _DollarRateState extends State<DollarRate> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: AnimatedGradientColoring(
        padding: 0,
        endColor: Color(0xFF2C627A),
        startColor: Color(0xFF285062),
        child: Container(
          height: size.height * .15,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(TImages.overlay),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Market Currency',
                        style: textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          letterSpacing: .75,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isLoading)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Center(
                    child: SizedBox(
                      width: size.width * 0.6,
                      child: GestureDetector(
                        onTap: () {
                          if (instance
                                  .calcResponse
                                  .value
                                  .amountStandardCurrency! >
                              0) {
                            instance.calcResponse.value.amountStandardCurrency =
                                0;
                            instance.dollar.value.clear();
                          }
                        },
                        child:
                            instance
                                    .calcResponse
                                    .value
                                    .amountStandardCurrency! >
                                0
                            ? Text(
                                TFormatter.formatDollar(
                                  instance
                                      .calcResponse
                                      .value
                                      .amountStandardCurrency!,
                                ),
                                style: textTheme.titleLarge!.copyWith(
                                  letterSpacing: 1.75,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: EditableText(
                                      focusNode: FocusNode(),
                                      cursorColor: TColors.light,
                                      controller: instance.dollar.value,
                                      backgroundCursorColor: TColors.secondary,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      style: textTheme.titleLarge!.copyWith(
                                        letterSpacing: 1.75,
                                        color: Colors.white,
                                      ),
                                      onChanged: (amount) {
                                        final amount = instance
                                            .dollar
                                            .value
                                            .text
                                            .trim();
                                        final amountIsValid =
                                            amount.isNotEmpty &&
                                            double.tryParse(amount) != null &&
                                            double.parse(amount) >= 10.0;
                                        if (amountIsValid) {
                                          THelperFunctions.debounce(() async {
                                            if (instance
                                                .network
                                                .value
                                                .isEmpty) {
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
                                                child:
                                                    CircularProgressIndicator(),
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
                                  SizedBox(width: TSizes.spaceBtwItems),
                                  Text(
                                    'USD',
                                    style: textTheme.titleLarge!.copyWith(
                                      letterSpacing: 1.75,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Default locale: ${Get.deviceLocale!.countryCode}',
                    style: textTheme.bodyLarge!.copyWith(
                      letterSpacing: .75,
                      color: TColors.light,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
