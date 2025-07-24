import '../controller/news_controller.dart';
import 'news_card_shimmer.dart';
import 'widget.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    final controller = NewsController.instance;

    return Obx(() {
      // Initial loading state
      if (controller.isInitialLoading.value) {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return const NewsCardShimmer();
          },
        );
      }

      // Empty state
      if (controller.displayedNews.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.article_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text('No news available', style: textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Check back later for updates', style: textTheme.bodyMedium),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.refreshData(),
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      }

      // News list with pagination
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              controller.hasMoreData.value == true &&
              controller.isLoadingMore.value == false) {
            controller.loadMore();
          }
          return false;
        },
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            if (index < controller.displayedNews.length) {
              final news = controller.displayedNews[index];
              return NewsCard(news: news);
            } else {
              // Loading shimmer cards for pagination
              return controller.isLoadingMore.value
                  ? Column(
                      children: List.generate(
                        1, // Show 1 shimmer card while loading more
                        (shimmerIndex) => const NewsCardShimmer(),
                      ),
                    )
                  : const SizedBox.shrink();
            }
          },
          itemCount:
              controller.displayedNews.length +
              (controller.hasMoreData.value == true ? 1 : 0),
          physics: const BouncingScrollPhysics(),
        ),
      );
    });
  }
}
