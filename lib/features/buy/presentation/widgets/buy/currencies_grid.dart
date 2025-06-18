import '../widgets.dart';

class CurrenciesGrid extends StatelessWidget {
  const CurrenciesGrid({super.key, required this.coinData});
  final CoinData coinData;

  @override
  Widget build(BuildContext context) {
    final instance = BuyController.instance;
    return SizedBox(
      height: Get.height,
      child: FutureBuilder(
        future: instance.fetchCurrencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              itemCount: 5,
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return CurrencyCardShimmer();
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 40),
                  const SizedBox(height: 8),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
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
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) {
              final currency = snapshot.requireData[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    instance.currencyId.value = currency.id;
                    Get.toNamed(Routers.buy, arguments: {'currency': currency, 'coinData': coinData});
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CircleAvatar(
                          child: FutureBuilder(
                            future: getImageWidget(
                              currency.imageFile,
                              context: context,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return const Icon(Icons.error);
                              }
                              return snapshot.data ?? const Icon(Icons.money);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currency.currencyName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
