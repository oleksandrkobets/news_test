import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_test/feature/home/data/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  final ArticleModel articleModel;

  const ArticlePage({
    required this.articleModel,
    super.key,
  });

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleModel.title ?? ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.articleModel.publishedAt != null)
                Text(
                  DateFormat('dd MMM yyyy')
                      .format(widget.articleModel.publishedAt!),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Author: '),
                  const SizedBox(width: 8),
                  Text(
                    widget.articleModel.author ?? 'Unknown',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (widget.articleModel.description != null)
                Text(
                  widget.articleModel.description ?? '',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                widget.articleModel.content ?? '',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                    ),
                maxLines: 12,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              if (widget.articleModel.url != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Read more at',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse(
                          widget.articleModel.url ?? '',
                        ));
                      },
                      child: Text(
                        '${widget.articleModel.url}',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
