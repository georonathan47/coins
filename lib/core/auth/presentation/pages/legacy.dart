import '../../../../features/homepage/data/models/data.dart';
import '../../../onboarding/presentation/widgets/widgets.dart';
import '../widgets/widgets.dart';

class LegacyUser extends StatefulWidget {
  const LegacyUser({super.key});

  @override
  State<LegacyUser> createState() => _LegacyUserState();
}

class _LegacyUserState extends State<LegacyUser> {
  final controller = PageController();
  final currentPage = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'welcome to the new experience'.capitalize!,
            style: textTheme.titleMedium,
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: [
          SizedBox.expand(
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(Routers.legacyEmail),
              child: Text(
                'Continue',
                style: textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
        body: ScrollableWidget(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              '''We’ve completely redesigned the application to provide a smoother, more secure, and user-friendly experience.
Please check your email for a link to reset your password before proceeding.
Explore the exciting updates we've introduced to make your journey even better:''',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: PageView.builder(
                pageSnapping: true,
                controller: controller,
                itemCount: legacyData.length,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => currentPage.value = index);
                  controller.jumpToPage(index);
                },
                itemBuilder: (context, index) => Card(
                  child: OnboardContent(
                    text: legacyData[index]["text"],
                    title: legacyData[index]["title"],
                    illustration: legacyData[index]["illustration"],
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                legacyData.length,
                (index) => DotIndicator(isActive: index == currentPage.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
