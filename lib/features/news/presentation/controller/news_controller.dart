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
  List<News> _displayedNews = [];
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  NewsController({
    required this.searchNewsUsecase,
    required this.fetchAllNewsUsecase,
  });

  List<News> get displayedNews => _displayedNews;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<List<News>> fetchAll() async {
    final result = await fetchAllNewsUsecase(NoParams());
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          title: 'Error!',
          message: failure.message,
          bgColor: TColors.error,
        );
        return Future.error(failure.message);
      },
      (success) {
        _allNews = success;
        _currentPage = 0;
        _displayedNews = _getPageData();
        _hasMoreData = _displayedNews.length < _allNews.length;
        return success;
      },
    );
  }

  void loadMore() {
    if (_isLoadingMore || !_hasMoreData) return;

    _isLoadingMore = true;
    update();

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _currentPage++;
      final newItems = _getPageData();
      _displayedNews.addAll(newItems);
      _hasMoreData = _displayedNews.length < _allNews.length;
      _isLoadingMore = false;
      update();
    });
  }

  List<News> _getPageData() {
    final startIndex = _currentPage * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, _allNews.length);

    if (startIndex >= _allNews.length) return [];
    return _allNews.sublist(startIndex, endIndex);
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
