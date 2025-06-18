import 'dart:async';

import '../../../../core/presentation/widgets/success_screen/error.dart';
import 'dashboard/trending_assets_shimmer.dart';
import 'widgets.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  late Timer _timer;
  final textTheme = Get.textTheme;
  late ScrollController _scrollController;
  final instance = DashboardController.instance;

  @override
  void initState() {
    super.initState();
    instance.onInit();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.offset;

        // If we've reached the end, jump back to the beginning
        if (currentScrollPosition >= maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          // Scroll to the next item
          _scrollController.animateTo(
            currentScrollPosition +
                120, // Adjust this value based on your TrendingAsset width
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    _startAutoScroll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      physics: const BouncingScrollPhysics(),
      children: [
        Obx(
          () => Text(
            'Hello, ${instance.currentUser.value.firstname}!',
            style: textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const PortfolioSummary(),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ActionButtons(),
        const SizedBox(height: TSizes.spaceBtwSections),
        Text(
          'Trending Assets',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: Get.height / 14,
          child: FutureBuilder(
            future: instance.fetchListings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => TrendingAssetShimmer(),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    elevation: 4,
                    shadowColor: TColors.dark,
                    child: Container(
                      width: Get.width - 32,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: TSizes.iconLg,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
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

              return SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.requireData.map((currency) {
                    return InkWell(
                      onTap: () => instance.showListingInfo(currency),
                      child: TrendingAsset(asset: currency),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        Text(
          'Assets',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: Get.height / 2.5,
          child: FutureBuilder(
            future: instance.fetchTradables(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 5,
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
                return FetchError(
                  message: 'No currencies found',
                  title: 'No Tradable Assets',
                );
              }

              return ListView.builder(
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
                    child: CurrencyCard(currency: coinData),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
