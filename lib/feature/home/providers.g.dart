// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeRepositoryHash() => r'0a08542f3cf9d0425f87a20b06020cdd03fa827f';

/// See also [homeRepository].
@ProviderFor(homeRepository)
final homeRepositoryProvider = AutoDisposeProvider<HomeRepository>.internal(
  homeRepository,
  name: r'homeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HomeRepositoryRef = AutoDisposeProviderRef<HomeRepository>;
String _$homeControllerHash() => r'015ebf572cf7e464aab97a9b0829fdb5c40f813b';

/// See also [HomeController].
@ProviderFor(HomeController)
final homeControllerProvider = AutoDisposeAsyncNotifierProvider<HomeController,
    List<ArticleModel>>.internal(
  HomeController.new,
  name: r'homeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeController = AutoDisposeAsyncNotifier<List<ArticleModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
