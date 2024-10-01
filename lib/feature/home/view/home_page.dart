import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_test/feature/home/providers.dart';
import 'package:news_test/feature/home/view/article_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? debounce;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.watch(homeControllerProvider.notifier).getArticles();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Test Demo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final articles = ref.watch(homeControllerProvider);

                return articles.when(
                  error: (error, stackTrace) => const Center(
                    child: Text('Error occured. Please try again'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (data) => data.isEmpty
                      ? const Center(
                          child: Text(
                            "No news found",
                          ),
                        )
                      : Expanded(
                          child: CustomScrollView(
                            controller: scrollController,
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) {
                                              return ArticlePage(
                                                articleModel: data[index],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 5,
                                        child: SizedBox(
                                          height: 32,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  data[index].title ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: data.length,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Visibility(
                                  visible: ref
                                                      .watch(
                                                          homeControllerProvider
                                                              .notifier)
                                                      .currentPage -
                                                  1 ==
                                              ref
                                                  .watch(homeControllerProvider
                                                      .notifier)
                                                  .lastPage ||
                                          data.isEmpty
                                      ? false
                                      : true,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
