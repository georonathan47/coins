import '../widgets/widgets.dart';

class ActionableBuy extends StatefulWidget {
  const ActionableBuy({super.key});

  @override
  State<ActionableBuy> createState() => ActionableBuyState();
}

class ActionableBuyState extends State<ActionableBuy> {
  final textTheme = Get.textTheme;
  final instance = DashboardController.instance;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          centerTitle: true,
          title: Text(
            'Select Currency',
            style: textTheme.titleLarge?.copyWith(color: TColors.light),
          ),
        ),
        body: FutureBuilder(
          future: instance.fetchTradables(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: 5,
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CurrencyCardShimmer();
                },
              );
            }

            if (snapshot.hasError) {
              return FetchError(message: '${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.requireData.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_outlined, size: 40),
                    SizedBox(height: 8),
                    Text('No currencies found'),
                  ],
                ),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.requireData.length,
              itemBuilder: (context, index) {
                final coinData = snapshot.requireData[index];
                return InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                    final result = await instance.fetchCurrencies();
                    final currency = result.firstWhere(
                      (element) => element.currencyName == coinData.name,
                    );
                    Get.back();
                    Get.toNamed(
                      Routers.buy,
                      arguments: {'coinData': coinData, 'currency': currency},
                    );
                  },
                  child: CurrencyGridCard(currency: coinData),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
