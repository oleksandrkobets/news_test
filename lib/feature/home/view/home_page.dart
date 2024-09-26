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
                  error: (error, stackTrace) => Center(
                    child: Text('Error occured. Please try again'),
                  ),
                  loading: () => const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  data: (data) => data.isEmpty
                      ? Center(
                          child: const Text(
                            "No news found",
                          ),
                        )
                      : Expanded(
                          child: CustomScrollView(
                            controller: scrollController,
                            slivers: [
                              SliverToBoxAdapter(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
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
                                  child: const CircularProgressIndicator(),
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
