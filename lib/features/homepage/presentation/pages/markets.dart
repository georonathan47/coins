import '../widgets/widgets.dart';

class MarketsPage extends StatefulWidget {
  const MarketsPage({super.key});

  @override
  State<MarketsPage> createState() => MarketsPageState();
}

class MarketsPageState extends State<MarketsPage> {
  final textTheme = Get.textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Markets', style: textTheme.titleLarge),
      ),
      body: const MarketsBody(),
    );
  }
}
