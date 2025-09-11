import 'widgets.dart';

class SellOrderHistoryBody extends StatelessWidget {
  const SellOrderHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Get.textTheme;
    return GetBuilder<SellController>(
      builder: (instance) => Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: instance.history(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 5,
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HistoryCardShimmer();
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

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task_outlined, size: 40),
                        SizedBox(height: 8),
                        Text('No order history found'),
                      ],
                    ),
                  );
                }
                // final filteredList = snapshot.data!.where((order) {
                //   final currentFilter = instance.filterStatus.value
                //       .toUpperCase();
                //   return order.status.toUpperCase() == currentFilter ||
                //       currentFilter.isEmpty;
                // }).toList();

                return ListView.builder(
                  itemCount: snapshot.requireData.length,
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final order = snapshot.requireData[index];
                    return Card(child: SellHistoryCard(order: order));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
