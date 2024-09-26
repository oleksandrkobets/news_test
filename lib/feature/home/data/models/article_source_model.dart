import 'package:json_annotation/json_annotation.dart';

part 'article_source_model.g.dart';

@JsonSerializable()
class ArticleSourseModel {
  final String? id;
  final String? name;

  ArticleSourseModel({
    required this.id,
    required this.name,
  });

  factory ArticleSourseModel.fromJson(Map<String, dynamic> json) {
    return _$ArticleSourseModelFromJson(json);
  }
}
