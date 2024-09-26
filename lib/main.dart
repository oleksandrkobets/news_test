import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_test/feature/home/view/home_page.dart';

void main() {
  runApp(
    UncontrolledProviderScope(
      container: ProviderContainer(),
      child: const TestNewsApp(),
    ),
  );
}

class TestNewsApp extends StatelessWidget {
  const TestNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
