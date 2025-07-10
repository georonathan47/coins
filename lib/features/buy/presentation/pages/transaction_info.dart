import '../widgets/widgets.dart';

class TransactionInfoPage extends StatefulWidget {
  const TransactionInfoPage({super.key});

  @override
  State<TransactionInfoPage> createState() => TransactionInfoPageState();
}

class TransactionInfoPageState extends State<TransactionInfoPage> {
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        centerTitle: true,
        leading: BackButton(color: TColors.light),
        title: Text(
          'Transaction Information',
          style: textTheme.titleMedium?.copyWith(color: TColors.light),
        ),
      ),
      body: TransactionInfoBody(),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        SizedBox(
          width: Get.width * 0.95,
          child: ElevatedButton.icon(
            label: Text('Submit Order'),
            iconAlignment: IconAlignment.end,
            icon: const Icon(Iconsax.arrow_right_3),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
             
              await instance.createOrder();
            },
          ),
        ),
      ],
    );
  }
}
