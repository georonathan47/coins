import 'widgets.dart';

class BuyOrderHistoryBody extends StatefulWidget {
  const BuyOrderHistoryBody({super.key});

  @override
  State<BuyOrderHistoryBody> createState() => BuyOrderHistoryBodyState();
}

class BuyOrderHistoryBodyState extends State<BuyOrderHistoryBody> {
  final textTheme = Get.textTheme;
  final instance = BuyController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  [
                        'Approved',
                        'Canceled',
                        'Completed',
                        'Pending Payment',
                        'Rejected',
                      ]
                      .map(
                        (status) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip.elevated(
                            // selected:
                            // instance.filterStatus.value ==
                            // status.replaceAll(' ', '_').toUpperCase(),
                            onSelected: (value) {
                              // setState(() {
                              //   if (value) {
                              //     instance.filterStatus.value = status
                              //         .replaceAll(' ', '_')
                              //         .toUpperCase();
                              //     instance.filterBool.value = true;
                              //   } else {
                              //     instance.filterStatus.value = '';
                              //     instance.filterBool.value = false;
                              //   }
                              // });
                            },
                            selectedColor: TColors.secondary,
                            backgroundColor: TColors.secondary.withOpacity(0.2),
                            label: Text(
                              status,
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 20,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
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
              final filteredList = snapshot.data!.where((order) {
                final currentFilter = instance.filterStatus.value
                    .toUpperCase();
                return order.status.toUpperCase() == currentFilter ||
                    currentFilter.isEmpty;
              }).toList();

              return ListView.builder(
                itemCount: filteredList.length,
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final order = filteredList[index];
                 return Card(child: BuyHistoryCard(order: order));
                },
              );
            },
          ),

        ),
      ],
    );
  }
}
