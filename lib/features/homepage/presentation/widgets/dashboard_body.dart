import 'dart:async';

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

  final List<String> _assets = [
    'Bitcoin',
    'Ethereum',
    'Dogecoin',
    'XRP',
    'USDt',
    'Binance Coin',
    'TrumpCoin',
  ];

  @override
  void initState() {
    super.initState();
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
        Text('Hello, World!', style: textTheme.titleLarge),
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
          height: MediaQuery.sizeOf(context).height / 15,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._assets.map((e) => TrendingAsset(asset: e)),
                ..._assets.map((e) => TrendingAsset(asset: e)),
                ..._assets.map((e) => TrendingAsset(asset: e)),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        Text(
          'Assets',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 3,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return AssetTile(
                title: 'Bitcoin ${index + 1}',
                subtitle: 'BTC',
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
