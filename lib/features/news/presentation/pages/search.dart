import '../../../../core/shared/helpers/helper_functions.dart';
import '../../domain/entities/news.dart';
import '../controller/news_controller.dart';
import '../widgets/widget.dart';

class NewsSearchDelegate extends SearchDelegate<String> {
  final searchResults = <News>[].obs;
  final instance = NewsController.instance;
  @override
  String get searchFieldLabel => 'Search news...';
  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      final results = await instance.search(query);
      searchResults.value = results;
    } catch (e) {
      searchResults.clear();
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Iconsax.arrow_left),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return NewsBody();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        THelperFunctions.debounce(() {
          performSearch(query);
        });

        if (searchResults.isEmpty && query.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.article_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No news match your search query',
                  style: Get.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Kindly search for something else...',
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }
        return Obx(() {
          return ListView.builder(
            itemCount: searchResults.length,
            padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
            itemBuilder: (context, index) {
              final result = searchResults[index];
              return NewsCard(news: result);
            },
          );
        });
      },
    );
  }
}
