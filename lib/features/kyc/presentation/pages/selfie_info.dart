import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/shared/constants/text_strings.dart';
import '../widgets/widgets.dart';

class KycSelfieInfo extends StatefulWidget {
  const KycSelfieInfo({super.key});

  @override
  State<KycSelfieInfo> createState() => KycSelfieInfoState();
}

class KycSelfieInfoState extends State<KycSelfieInfo> {
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(backgroundColor: TColors.transparent),
        body: ScrollableWidget(
          children: [
            SvgPicture.asset(
              SvgAssets.todo,
              fit: BoxFit.cover,
              height: Get.height * 0.25,
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            Text(
              "Prepare to take a selfie",
              textAlign: TextAlign.center,
              style: textTheme.titleLarge!.copyWith(
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections / 2),
            Text(
              "Get ready to capture a clear and centered selfie. Ensure good lighting and a neutral background for the best results.",
              textAlign: TextAlign.center,
              style: textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            const KYCInformatics(
              icon: FontAwesomeIcons.minimize,
              title: "Position your ID close to your face",
              message:
                  "Review and confirm that your personal information is accurate.",
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            const KYCInformatics(
              icon: Iconsax.camera,
              title: "Capture Your Selfie",
              message:
                  "Take a selfie, making sure that your face and your ID are well lit with no shadows.",
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routers.selfieUpload),
              child: Text(
                TTexts.tContinue,
                style: textTheme.titleMedium?.copyWith(
                  color: TColors.light,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Need help? ',
                  style: textTheme.labelLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' Contact Support',
                      style: textTheme.labelLarge!.copyWith(
                        fontSize: 16,
                        color: TColors.accent,
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
    );
  }
}
