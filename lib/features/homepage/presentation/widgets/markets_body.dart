import 'widgets.dart';

class MarketsBody extends StatelessWidget {
  const MarketsBody({super.key});

  @override
  Widget build(BuildContext context) {
    late Future <List<CoinData>> marketDataFuture;
    final textTheme = Get.textTheme;
    return GetBuilder<DashboardController>(
      builder: (instance) {
        marketDataFuture = instance.fetchMarketData();
        return FutureBuilder(
          future: marketDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: textTheme.bodyMedium,
                ),
              );
            } else if (snapshot.hasData) {
              final marketData = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: TGridLayout(
                  itemCount: marketData.length,
                  itemBuilder: (context, index) {
                    final data = marketData[index];
                    return MarketCard(data: data);
                  },
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No market data available.',
                  style: textTheme.bodyMedium,
                ),
              );
            }
          },
        );
      },
    );
  }
}
