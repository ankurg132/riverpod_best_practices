import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/common/params.dart';
import 'package:flutter_riverpod_demo/posts/notifier/post_state.dart';
import 'package:flutter_riverpod_demo/posts/repository/post_repository.dart';

final postNotifierProvider = AsyncNotifierProvider<PostNotifier, PostState>(
  () => PostNotifier(),
);

class PostNotifier extends AsyncNotifier<PostState> {
  @override
  FutureOr<PostState> build() async {
    final repository = ref.watch(postRepositoryNotifier);
    final response = await repository.fetchPost();
    return PostState(
      data: response,
      currentPage: 1,
      hasMoreData: (response?.length ?? 0) >= ApiParams.pageLimit,
      nextPostLoading: false,
    );
  }

  Future fetchPosts() async {
    if (state.isLoading) return;
    state = AsyncLoading();
    final repository = ref.read(postRepositoryNotifier);
    state = await AsyncValue.guard(() async {
      final response = await repository.fetchPost();
      return PostState(data: response, currentPage: 1, hasMoreData: true);
    });
  }

  Future fetchPaginatedPosts() async {
    if (!state.hasValue || state.isLoading) return;
    final currentState = state.requireValue;

    if (!currentState.hasMoreData || currentState.nextPostLoading) return;
    final currentResponse = currentState.data;
    state = AsyncData(currentState.copyWith(nextPostLoading: true));
    final repository = ref.read(postRepositoryNotifier);
    state = await AsyncValue.guard(() async {
      int? currentPage = state.value?.currentPage;
      int nextPage = (currentPage ?? 0) + 1;
      final response = await repository.fetchPaginatedPost(nextPage);
      return PostState(
        data: [...?currentResponse, ...?response],
        currentPage: nextPage,
        hasMoreData: response?.length == ApiParams.pageLimit ? true : false,
      );
    });
  }
}
