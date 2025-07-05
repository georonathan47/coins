import 'package:flutter_confetti/flutter_confetti.dart';

import '../widgets/widgets.dart';

class KycSuccess extends StatefulWidget {
  const KycSuccess({super.key});

  @override
  State<KycSuccess> createState() => KycSuccessState();
}

class KycSuccessState extends State<KycSuccess> {
  final textTheme = Get.textTheme;
  final controller = ConfettiController();

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: TColors.transparent,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Confetti(
              instant: true,
              controller: controller,
              options: ConfettiOptions(
                particleCount: 250,
                colors: const [
                  TColors.primary,
                  TColors.accent,
                  TColors.light,
                  TColors.secondary,
                  TColors.error,
                  TColors.success,
                  TColors.warning,
                ],
              ),
            ),
            ScrollableWidget(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: TSizes.spaceBtwSections * 2),
                SvgPicture.asset(
                  SvgAssets.kycSuccess,
                  fit: BoxFit.cover,
                  height: Get.height * 0.25,
                ),
                SizedBox(height: TSizes.spaceBtwSections * 2),
                Text(
                  'Congratulations! You have initiated your KYC verification process.',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    letterSpacing: .75,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                RichText(
                  text: TextSpan(
                    text:
                        'You have successfully submitted your information. This would take ',
                    style: textTheme.bodyLarge!.copyWith(letterSpacing: .75),

                    children: [
                      TextSpan(
                        text: '4-5 business days ',
                        style: textTheme.bodyLarge!.copyWith(
                          letterSpacing: .75,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'to process. Kindly be patient while we review.',
                        style: textTheme.bodyLarge!.copyWith(
                          letterSpacing: .75,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections * 2),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routers.index);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
