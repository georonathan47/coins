import '../widgets.dart';

class DollarRate extends StatefulWidget {
  const DollarRate({super.key});

  @override
  State<DollarRate> createState() => _DollarRateState();
}

class _DollarRateState extends State<DollarRate> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
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
                      'Market Currency',
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
                        controller: amountController,
                        cursorColor: TColors.light,
                        onChanged: TValidator.validateAmount,
                        backgroundCursorColor: TColors.secondary,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: textTheme.titleLarge!.copyWith(
                          letterSpacing: 1.75,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: IntrinsicHeight(
                      child: RichText(
                        text: TextSpan(
                          text:
                              'Default locale is set to ${Get.deviceLocale!.countryCode}',
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
    );
  }
}
