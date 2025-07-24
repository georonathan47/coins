import '../widgets/widget.dart';
import 'search.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News', style: textTheme.titleLarge),
        actionsPadding: const EdgeInsetsDirectional.only(end: TSizes.md),
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: NewsSearchDelegate(),
            ),
            icon: const Icon(Iconsax.search_favorite),
          ),
        ],
      ),
      body: const NewsBody(),
    );
  }
}
