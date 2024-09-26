import 'package:news_test/feature/home/data/models/article_model.dart';
import 'package:news_test/feature/home/data/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

const defaultPageSize = 20;

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

@riverpod
class HomeController extends _$HomeController {
  HomeRepository get _repository => ref.watch(homeRepositoryProvider);

  List<ArticleModel> items = [];

  @override
  FutureOr<List<ArticleModel>> build() async {
    getArticles();
    return items;
  }

  int currentPage = 1;
  int lastPage = 1;

  void getArticles() async {
    try {
      if (currentPage <= lastPage) {
        final articlesList = await _repository.getArticlesList(
          pageSize: defaultPageSize,
          pageNumber: currentPage,
        );
        currentPage += 1;

        items.addAll(articlesList.articles);

        lastPage = (articlesList.totalResults ~/ defaultPageSize) + 1;

        state = AsyncValue.data(items);
      }
    } catch (e) {
      rethrow;
    }
  }
}
