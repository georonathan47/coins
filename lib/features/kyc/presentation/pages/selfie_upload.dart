import 'dart:io';

import '../widgets/widgets.dart';

class KycSelfieUpload extends StatefulWidget {
  const KycSelfieUpload({super.key});

  @override
  State<KycSelfieUpload> createState() => KycSelfieUploadState();
}

class KycSelfieUploadState extends State<KycSelfieUpload> {
  final textTheme = Get.textTheme;
  final instance = KycController.instance;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: TColors.transparent,
          title: Text(
            'Upload Selfie Image',
            style: textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          actions: [
            IconButton(icon: const Icon(Iconsax.info_circle), onPressed: () {}),
          ],
        ),
        body: ScrollableWidget(
          physics: const BouncingScrollPhysics(),
          children: [
            Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: TColors.accent.withOpacity(.1),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                height: Get.height / 15,
                child: Center(
                  child: Text(
                    'Please ensure all images adhere to the specified requirement before proceeding',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      color: TColors.accent,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwSections / 2),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              height: instance.selfie.value.value.isEmpty
                  ? Get.height * 0.2
                  : Get.height * 0.25,
              child: GFBorder(
                strokeWidth: 2,
                type: GFBorderType.rRect,
                dashedLine: const [15, 10],
                radius: const Radius.circular(10),
                color: Get.isDarkMode
                    ? Colors.white54
                    : TColors.primary.withOpacity(0.65),
                child: Column(
                  children: [
                    instance.selfie.value.value.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Upload your selfie image',
                              style: textTheme.titleMedium,
                            ),
                          )
                        : const SizedBox.shrink(),
                    instance.selfie.value.value.isEmpty
                        ? Text('JPG, PNG, GIF', style: textTheme.titleSmall)
                        : const SizedBox.shrink(),
                    instance.selfie.value.value.isEmpty
                        ? const SizedBox(height: 20)
                        : const SizedBox.shrink(),
                    instance.selfie.value.value.isEmpty
                        ? SizedBox(
                            width: Get.width / 4,
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await instance.openGallery();
                                if (result.isNotEmpty) {
                                  setState(
                                    () => instance.selfie.value.value = result,
                                  );
                                }
                              },
                              child: Text(
                                'Take Selfie',
                                style: textTheme.labelLarge,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    ValueListenableBuilder(
                      valueListenable: instance.selfie.value,
                      builder: (context, value, child) {
                        if (value.isNotEmpty) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(value),
                                  fit: BoxFit.contain,
                                  height: Get.height * 0.225,
                                ),
                              ),
                              Positioned(
                                left: Get.width * 0.55,
                                child: Card(
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(
                                        () => instance.selfie.value.value = '',
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: TColors.accent.withOpacity(.1),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                height: Get.height / 4.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions to follow:',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    InstructionsWidget(
                      instruction:
                          'Ensure the document and face are clear and readable, with no blurriness or distortion.',
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    InstructionsWidget(
                      instruction:
                          'Take a selfie with your ID held closely for successful verification.',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            ElevatedButton(
              onPressed: () => instance.validateDocs(),
              child: Text(
                'Next',
                style: textTheme.titleMedium?.copyWith(
                  color: TColors.light,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            OutlinedButton(
              onPressed: () => Get.offAllNamed(Routers.index),
              child: Text(
                'Continue Later',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
