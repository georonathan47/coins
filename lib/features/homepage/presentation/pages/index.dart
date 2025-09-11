import 'package:upgrader/upgrader.dart';


import '../widgets/widgets.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => IndexState();
}

class IndexState extends State<Index> with AutomaticKeepAliveClientMixin {
  final _currentIndex = 0.obs;
  late PageController _pageController;
  final instance = DashboardController.instance;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
    _currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Get.textTheme;
    return FlavorBanner(
      child: Scaffold(
        body: UpgradeAlert(
          shouldPopScope: () => false,
          dialogStyle: UpgradeDialogStyle.cupertino,
          upgrader: Upgrader(
            debugLogging: kDebugMode,
            debugDisplayAlways: kDebugMode,
          ),
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (index) => _currentIndex.value = index,
                children: [
                  Dashboard(),
                  Center(child: Text('Market')),
                  NewsPage(),
                  ProfilePage(),
                ],
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.015,
                bottom: MediaQuery.of(context).size.height * 0.015,
                child: FoldableOptions(
                  onTap: [
                    // () => Get.toNamed(Routers.chatList), // Chat
                    // () => Get.toNamed(Routers.family), // Family
                    () => _navigateToPage(0), // Rewards
                    () => _navigateToPage(1), // Rewards
                    () => _navigateToPage(2), // Rewards
                    () => _navigateToPage(3), // Claims
                    // () => _navigateToPage(4), // Profile
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1.5, color: TColors.lightGrey),
          ),
          child: FloatingActionButton(
            onPressed: () => instance.openTrade(),
            backgroundColor: TColors.primary,
            child: const Icon(Iconsax.arrow_3, color: TColors.light),
          ),
        ),
        bottomNavigationBar: Obx(
          () => ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: AnimatedBottomNavigationBar.builder(
              notchMargin: -8.5,
              leftCornerRadius: 16,
              rightCornerRadius: 16,
              itemCount: indexList.length,
              gapLocation: GapLocation.center,
              onTap: (i) => _navigateToPage(i),
              activeIndex: _currentIndex.value,
              backgroundColor: TColors.primary,
              tabBuilder: (index, val) {
                return Column(
                  children: [
                    SizedBox(height: Get.height * 0.014),
                    Expanded(
                      child: Icon(
                        indexList[index]['icon'] as IconData?,
                        color: (_currentIndex.value == index)
                            ? Colors.white
                            : Colors.white70,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.012),
                    Expanded(
                      child: Text(
                        indexList[index]['name'] as String,
                        style: textTheme.bodySmall!.copyWith(
                          color: (_currentIndex.value == index)
                              ? Colors.white
                              : Colors.white70,
                          fontWeight: _currentIndex.value == index
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
