import 'package:json_annotation/json_annotation.dart';
import 'package:news_test/feature/home/data/models/article_model.dart';

part 'news_list.g.dart';

@JsonSerializable()
class NewsList {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  NewsList({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsList.fromJson(Map<String, dynamic> json) {
    return _$NewsListFromJson(json);
  }
}
