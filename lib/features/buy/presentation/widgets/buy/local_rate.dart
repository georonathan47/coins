import '../../controller/buy_controller.dart';
import '../widgets.dart';

class LocalRate extends StatefulWidget {
  const LocalRate({super.key, required this.coinData});
  final CoinData coinData;

  @override
  State<LocalRate> createState() => _LocalRateState();
}

class _LocalRateState extends State<LocalRate> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;

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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      SizedBox(height: TSizes.spaceBtwItems),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.6,
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
                              if (amount.isNotEmpty) {
                                THelperFunctions.debounce(() async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                  instance.currencyId.value =
                                      widget.coinData.id;
                                  await instance.calculate();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwSections),
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
