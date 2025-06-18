import 'package:flutter/cupertino.dart';

import '../widgets/widgets.dart';

class KycHome extends StatefulWidget {
  const KycHome({super.key});

  @override
  State<KycHome> createState() => KycHomeState();
}

class KycHomeState extends State<KycHome> {
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
              "Let's get you verified",
              textAlign: TextAlign.center,
              style: textTheme.titleLarge!.copyWith(
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections / 2),
            Text(
              "You are in good hands. Follow our lead through the following verification stages.",
              textAlign: TextAlign.center,
              style: textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            const KYCInformatics(
              icon: CupertinoIcons.person_alt_circle,
              title: "Confirm your personal details",
              message:
                  "Review and confirm that your personal information is accurate.",
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            const KYCInformatics(
              icon: Iconsax.document_upload,
              title: "Upload a scanned valid ID",
              message:
                  "Scan and submit a well-lit copy of your valid identity document.",
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            const KYCInformatics(
              icon: Iconsax.camera,
              title: "Upload a selfie with your ID",
              message:
                  "Capture a selfie while holding your ID close to your facet.",
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routers.kycPersonalDetails),
              child: Text(
                'Get Started',
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
