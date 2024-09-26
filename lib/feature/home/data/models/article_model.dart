import 'package:json_annotation/json_annotation.dart';
import 'package:news_test/feature/home/data/models/article_source_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final ArticleSourseModel source;
  final String? author;
  final String? description;
  final String? title;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticleModel({
    required this.source,
    required this.author,
    required this.description,
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return _$ArticleModelFromJson(json);
  }
}
