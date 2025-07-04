import '../widgets/widgets.dart';

class BuySummary extends StatefulWidget {
  const BuySummary({super.key});

  @override
  State<BuySummary> createState() => BuySummaryState();
}

class BuySummaryState extends State<BuySummary> {
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          title: Text(
            'Buy Order Summary',
            style: textTheme.titleMedium?.copyWith(color: TColors.light),
          ),
        ),
        body: BuySummaryBody(),
      ),
    );
  }
}
