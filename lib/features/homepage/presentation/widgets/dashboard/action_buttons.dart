import 'package:google_fonts/google_fonts.dart';

import '../widgets.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({super.key});

  @override
  State<ActionButtons> createState() => ActionButtonsState();
}

class ActionButtonsState extends State<ActionButtons> {
  final isDark = Get.isDarkMode;
  final textTheme = Get.textTheme;
  IconData checkIcon(String text) {
    IconData? icon;
    switch (text) {
      case 'Buy':
        icon = CupertinoIcons.down_arrow;
      case 'Sell':
        icon = CupertinoIcons.up_arrow;
      case 'PayAccount':
        icon = CupertinoIcons.money_dollar;
      case 'More':
        icon = CupertinoIcons.ellipsis;
    }
    return icon!;
  }

  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   onTap: () {},
    //   child: Column(
    //     children: [
    //       Container(
    //         width: 55,
    //         height: 55,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(8),
    //           border: Border.all(
    //             width: 1.5,
    //             color: isDark ? Colors.white54 : TColors.primary,
    //           ),
    //         ),
    //         child: Center(
    //           child: Icon(
    //             checkIcon(text),
    //             color: isDark ? Colors.white : TColors.primary,
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: TSizes.spaceBtwInputFields),
    //       Text(text, style: textTheme.bodyLarge),
    //     ],
    //   ),
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Buy', 'Sell', 'PayAccount', 'More']
          .map(
            (status) => InkWell(
              // customBorder: const CircleBorder(),
              borderRadius: BorderRadius.circular(25),
              splashColor: isDark ? TColors.darkerGrey : TColors.grey,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2.0,
                          color: isDark ? Colors.white70 : TColors.primary,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black12
                                : Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          checkIcon(status),
                          size: 28,
                          color: isDark ? Colors.white : TColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                        textStyle: textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
