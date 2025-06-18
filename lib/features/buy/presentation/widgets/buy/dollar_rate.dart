import '../widgets.dart';

class DollarRate extends StatefulWidget {
  const DollarRate({super.key});

  @override
  State<DollarRate> createState() => _DollarRateState();
}

class _DollarRateState extends State<DollarRate> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;
  bool _isLoading = false;

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
              padding: const EdgeInsets.all(10),
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
                      if (_isLoading)
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
                  SizedBox(height: TSizes.spaceBtwSections),
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
                                        setState(() => _isLoading = true);
                                        THelperFunctions.debounce(() async {
                                          try {
                                            await instance.calculate();
                                          } finally {
                                            if (mounted) {
                                              setState(
                                                () => _isLoading = false,
                                              );
                                            }
                                          }
                                        });
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
