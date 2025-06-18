import '../widgets/widgets.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => PersonalDetailsState();
}

class PersonalDetailsState extends State<PersonalDetails> {
  late DateTime date;
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TColors.transparent,
          title: Text('Confirm Personal Details', style: textTheme.titleLarge),
        ),
        body: ScrollableWidget(
          children: [
            Text(
              'Please verify and confirm your personal information below',
              textAlign: TextAlign.left,
              style: textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections / 2),
            const PersonalDetailsForm(),
          ],
        ),
      ),
    );
  }
}
