import 'package:dio/dio.dart';
import 'package:news_test/feature/home/data/models/news_list.dart';

class HomeRepository {
  final _dio = Dio();
  final _baseUrl = 'https://newsapi.org/v2/everything';
  final _apiKey = 'fff79cb791cd490f846d0fd06137b379';

  HomeRepository get instance {
    return this;
  }

  Future<NewsList> getArticlesList({
    required int pageSize,
    required int pageNumber,
  }) async {
    try {
      final articlesList = await _dio.get(
        _baseUrl,
        queryParameters: {
          'pageSize': pageSize,
          'page': pageNumber,
          'apiKey': _apiKey,
          'sortBy': 'popularity',
          'from': DateTime.now().subtract(const Duration(days: 30)),
          'domains': ['bbc.co.uk', 'techcrunch.com', 'thenextweb.com'],
        },
      );

      final newsList = NewsList.fromJson(articlesList.data);

      return newsList;
    } catch (e) {
      print(e);
      return NewsList(
        status: 'fail',
        totalResults: 0,
        articles: [],
      );
    }
  }
}
