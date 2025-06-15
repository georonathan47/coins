import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../flavors.dart';
import '../../auth/data/datasources/auth_local_database.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/time.dart';
import '../../constants/image_strings.dart';
import '../../data/routes.dart';
import '../../onboarding/data/datasources/local_database.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    // setup routing to login if user has seen onboarding
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> goToLogin() async {
    Get.offNamed(Routers.login);
  }

  Future<void> gotToHomepage() async {
    Get.offNamed(Routers.index);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Get.isDarkMode ? TColors.dark : TColors.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Get.isDarkMode ? TColors.dark : TColors.primary,
              Get.isDarkMode
                  ? TColors.dark.withOpacity(0.8)
                  : TColors.primary.withOpacity(0.8),
              Get.isDarkMode ? TColors.darkContainer : TColors.secondary,
            ],
          ),
        ),
        child: Stack(
          children: [
            TweenAnimationBuilder(
              curve: Curves.linear,
              duration: const Duration(seconds: 3),
              tween: Tween<double>(begin: -100.0, end: 0.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: Container(color: TColors.primary),
                );
              },
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Get.isDarkMode ? TColors.dark : TColors.primary,
                    Get.isDarkMode
                        ? TColors.dark.withOpacity(0.8)
                        : TColors.primary.withOpacity(0.8),
                    Get.isDarkMode ? TColors.darkContainer : TColors.secondary,
                  ],
                ),
              ),
            ),

            // Animated background particles
            ...List.generate(
                  20,
                  (index) => Positioned(
                    left: (index * 20).toDouble(),
                    top: (index * 30).toDouble(),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .moveY(
                  duration: const Duration(seconds: 3),
                  begin: 0,
                  end: 100,
                  curve: Curves.easeInOut,
                )
                .fade(duration: twoSecondDelay, curve: Curves.easeIn),

            Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  // Logo with scale and rotation animations
                  ScaleTransition(
                        scale: CurvedAnimation(
                          parent: _scaleController,
                          curve: Curves.elasticOut,
                        ),
                        child: RotationTransition(
                          turns: CurvedAnimation(
                            parent: _rotationController,
                            curve: Curves.easeInOut,
                          ).drive(Tween(begin: -0.02, end: 0.02)),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  Get.isDarkMode
                                      ? TImages.logo
                                      : TImages.logoWhite,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.325,
                                ),
                                Text(
                                  F.title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: TColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fade(duration: twoSecondDelay)
                      .scale(delay: const Duration(milliseconds: 500)),

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),

                  // Main title with typewriter effect
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child:
                        Text(
                              "Ready to transform your finances?".capitalize!,
                              textAlign: TextAlign.center,
                              style: textTheme.titleMedium!.copyWith(
                                letterSpacing: 1,
                                color: TColors.primaryBackground,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: oneSecondDelay)
                            .moveX(
                              begin: -30,
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutQuad,
                            ),
                  ),

                  SizedBox(height: TSizes.spaceBtwItems),

                  // Subtitle with slide-up animation
                  Text(
                        "Hit 'Get Started' And Join The Crypto Revolution!",
                        // .capitalize!,
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium!.copyWith(
                          color: TColors.primaryBackground,
                        ),
                      )
                      .animate()
                      .fadeIn(
                        delay: const Duration(milliseconds: 1500),
                        duration: const Duration(milliseconds: 500),
                      )
                      .moveY(
                        begin: 30,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutQuad,
                      ),

                  SizedBox(height: TSizes.spaceBtwSections),
                  // Get Started button
                  SizedBox(
                    width: MediaQuery.sizeOf(Get.context!).width * 0.5,
                    child: ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: () async {
                        final authState = await Get.find<AuthLocalDatabase>()
                            .authenticationStatus();
                        final onboard =
                            await Get.find<OnboardingLocalDatabase>()
                                .retrieveOnboardingStatus();
                        if (onboard && authState) {
                          // final user = await Get.find<AuthLocalDatabase>().retrieve();
                          gotToHomepage();
                        } else if (onboard && !authState) {
                          goToLogin();
                        } else {
                          Get.offNamed(Routers.onboard);
                        }
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 35,
                        color: TColors.primary,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primaryBackground,
                      ),
                      label: Text(
                        'Get Started',
                        style: textTheme.titleMedium?.copyWith(
                          color: TColors.primary,
                        ),
                      ),
                    ).animate().fadeIn(),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: ' © ${DateTime.now().year} . Powered by ',
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: TColors.primaryBackground,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: 'NICS',
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
