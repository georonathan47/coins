import '../widgets/widgets.dart';

class KycDocUpload extends StatefulWidget {
  const KycDocUpload({super.key});

  @override
  State<KycDocUpload> createState() => KycDocUploadState();
}

class KycDocUploadState extends State<KycDocUpload> {
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
            'Upload Identification',
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
                    'Please ensure all details are accurate before proceeding',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: TColors.accent,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: TSizes.spaceBtwSections),
            // const DocUploadForm(),
            Text(
              'Select the type of document you are uploading',
              style: textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            const DocUploadForm(),
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
