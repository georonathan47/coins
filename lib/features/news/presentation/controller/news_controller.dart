import '../../../../core/shared/helpers/helper_functions.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../domain/entities/news.dart';
import '../../domain/usecases/fetch_all_news_usecase.dart';
import '../../domain/usecases/search_news_usecase.dart';
import '../widgets/widget.dart';

class NewsController extends GetxController {
  final newsList = <News>[].obs;
  final SearchNewsUsecase searchNewsUsecase;
  final FetchAllNewsUsecase fetchAllNewsUsecase;
  static NewsController get instance => Get.find();

  List<News> _allNews = [];
  final displayedNews = <News>[].obs;
  int _currentPage = 0;
  final int _pageSize = 10;
  final isLoadingMore = false.obs;
  final hasMoreData = true.obs;
  final isInitialLoading = true.obs;

  NewsController({
    required this.searchNewsUsecase,
    required this.fetchAllNewsUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    if (_allNews.isNotEmpty) return; // Prevent multiple calls
    
    isInitialLoading.value = true;
    final result = await fetchAllNewsUsecase(NoParams());
    
    result.fold(
      (failure) {
        isInitialLoading.value = false;
        THelperFunctions.showSnackBar(
          title: 'Error!',
          message: failure.message,
          bgColor: TColors.error,
        );
      },
      (success) {
        _allNews = success;
        _currentPage = 0;
        displayedNews.value = _getPageData();
        hasMoreData.value = displayedNews.length < _allNews.length;
        isInitialLoading.value = false;
      },
    );
  }

  void loadMore() {
    if (isLoadingMore.value || !hasMoreData.value) return;

    isLoadingMore.value = true;

    // Simulate loading delay for better UX
    Future.delayed(const Duration(milliseconds: 800), () {
      _currentPage++;
      final newItems = _getPageData();
      displayedNews.addAll(newItems);
      hasMoreData.value = displayedNews.length < _allNews.length;
      isLoadingMore.value = false;
    });
  }

  List<News> _getPageData() {
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, _allNews.length);

    if (startIndex >= _allNews.length) return [];
    return _allNews.sublist(startIndex, endIndex);
  }

  void refreshData() {
    _allNews.clear();
    displayedNews.clear();
    _currentPage = 0;
    hasMoreData.value = true;
    isLoadingMore.value = false;
    fetchAll();
  }

  Future<List<News>> search(String query) async {
    final result = await searchNewsUsecase(ObjectParams(query));
    return result.fold((failure) {
      THelperFunctions.showSnackBar(
        title: 'Error!',
        message: failure.message,
        bgColor: TColors.error,
      );
      return Future.error(failure.message);
    }, (success) => success);
  }
}
