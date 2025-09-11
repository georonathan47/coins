import '../../../auth/presentation/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:upgrader/upgrader.dart';

import '../../../shared/constants/svg_assets.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  final currentPage = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () async {
                if (currentPage.value != demoData.length - 1) {
                  setState(() => currentPage.value++);
                  controller.jumpToPage(currentPage.value);
                } else {
                  await OnboardingController.instance.onboardingComplete();
                  Get.offAllNamed(Routers.login);
                }
              },
              child: Text("Next", style: textTheme.bodyLarge),
            ),
            Visibility(
              visible: currentPage.value != demoData.length - 1,
              child: TextButton(
                onPressed: () async {
                  await OnboardingController.instance.onboardingComplete();
                  Get.offAllNamed(Routers.login);
                },
                child: Text("Skip", style: textTheme.bodyLarge),
              ),
            ),
          ],
        ),
        body: UpgradeAlert(
          shouldPopScope: () => false,
          dialogStyle: UpgradeDialogStyle.cupertino,
          upgrader: Upgrader(
            // debugLogging: kDebugMode,
            // debugDisplayAlways: kDebugMode,
            durationUntilAlertAgain: kDebugMode
                ? Duration(minutes: 5)
                : Duration(hours: 2),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                Expanded(
                  flex: 14,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: demoData.length,
                    onPageChanged: (index) {
                      // check if current page
                      setState(() => currentPage.value = index);
                      // currentPage.value = index;
                      controller.jumpToPage(index);
                    },
                    itemBuilder: (context, index) => OnboardContent(
                      illustration: demoData[index]["illustration"],
                      title: demoData[index]["title"],
                      text: demoData[index]["text"],
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    demoData.length,
                    (index) =>
                        DotIndicator(isActive: index == currentPage.value),
                  ),
                ),
                const Spacer(flex: 2),
                Visibility(
                  visible: currentPage.value == demoData.length - 1,
                  child: SizedBox(
                    width: Get.width * .5,
                    child: ElevatedButton(
                      onPressed: () async {
                        await OnboardingController.instance
                            .onboardingComplete();
                        Get.offAllNamed(Routers.login);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Carry On".toUpperCase()),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "illustration": SvgAssets.btc,
    "title": "Secure Your Crypto Wallet",
    "text":
        "Keep your digital assets safe with top-notch security.\n"
        "Protect your investments with multi-layer encryption and secure backups.",
  },
  {
    "illustration": SvgAssets.assets,
    "title": "Track Your Portfolio",
    "text":
        "Monitor all your crypto holdings in one place.\n"
        "Get real-time updates and insights to make informed decisions.",
  },
  {
    "illustration": SvgAssets.btc,
    "title": "Earn Rewards & Grow",
    "text": """
Stake your crypto and earn rewards.
Participate in exclusive offers and promotions.\n
Watch your assets grow with smart investment options.""",
  },
];
