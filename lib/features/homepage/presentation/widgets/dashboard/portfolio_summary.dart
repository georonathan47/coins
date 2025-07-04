
import '../widgets.dart';

class PortfolioSummary extends StatefulWidget {
  const PortfolioSummary({super.key});

  @override
  State<PortfolioSummary> createState() => PortfolioSummaryState();
}

class PortfolioSummaryState extends State<PortfolioSummary> {
  final textTheme = Get.textTheme;
  final showPortfolio = ValueNotifier(false);
  final size = MediaQuery.of(Get.context!).size;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: AnimatedGradientColoring(
        padding: 0,
        endColor: Color(0xFF2C627A),
        startColor: Color(0xFF285062),
        child: Container(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Portfolio Summary',
                          style: textTheme.titleMedium!.copyWith(
                            letterSpacing: .75,
                            color: Colors.white,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: showPortfolio,
                          builder: (context, value, child) {
                            return IconButton(
                              color: Colors.white,
                              iconSize: TSizes.iconLg,
                              splashColor: Colors.white54,
                              tooltip: 'Show/Hide Portfolio',
                              icon: Icon(
                                value ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                showPortfolio.value = !value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  ValueListenableBuilder(
                    valueListenable: showPortfolio,
                    builder: (context, value, child) {
                      return Center(
                        child: AnimatedCrossFade(
                          duration: const Duration(milliseconds: 500),
                          crossFadeState: value
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: RichText(
                            text: TextSpan(
                              text: '5000',
                              style: GoogleFonts.raleway(
                                textStyle: textTheme.displaySmall!.copyWith(
                                  color: TColors.light,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: '.75',
                                  style: GoogleFonts.raleway(
                                    textStyle: textTheme.displaySmall!.copyWith(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: ' USD',
                                  style: GoogleFonts.raleway(
                                    textStyle: textTheme.bodyLarge!.copyWith(
                                      color: TColors.light,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondChild: RichText(
                            text: TextSpan(
                              text: '*****',
                              style: textTheme.displaySmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '.**',
                                  style: textTheme.displaySmall!.copyWith(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  IntrinsicHeight(
                    child: RichText(
                      text: TextSpan(
                        text: 'Total Profit/Loss: ',
                        style: textTheme.bodyLarge!.copyWith(
                          letterSpacing: 1.75,
                          color: TColors.light,
                          fontWeight: FontWeight.bold,
                        ),

                        children: [
                          TextSpan(
                            text: '+3.5%',
                            style: textTheme.bodyLarge!.copyWith(
                              letterSpacing: 1.75,
                              color: TColors.light,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
