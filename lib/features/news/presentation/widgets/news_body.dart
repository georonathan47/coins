import '../controller/news_controller.dart';
import 'news_card.dart';
import 'news_card_shimmer.dart';
import 'widget.dart';
import '../../domain/entities/news.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<NewsController>(
      builder: (instance) => FutureBuilder<List<News>>(
        future: instance.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (ctx, index) {
                return const NewsCardShimmer();
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text('Error loading news', style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => instance.update(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text('No news available', style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Check back later for updates',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return GetBuilder<NewsController>(
            builder: (controller) {
              final displayedNews = controller.displayedNews;
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.hasMoreData &&
                      !controller.isLoadingMore) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    if (index < displayedNews.length) {
                      final news = displayedNews[index];
                      return NewsCard(news: news);
                    } else {
                      // Loading indicator for more items
                      return controller.isLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                  itemCount:
                      displayedNews.length + (controller.hasMoreData ? 1 : 0),
                  physics: const BouncingScrollPhysics(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
