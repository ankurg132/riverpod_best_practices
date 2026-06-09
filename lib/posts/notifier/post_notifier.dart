import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/posts/model/post_model.dart';
import 'package:flutter_riverpod_demo/posts/repository/post_repository.dart';

final postNotifierProvider =
    AsyncNotifierProvider<PostNotifier, List<PostModel>?>(() => PostNotifier());

class PostNotifier extends AsyncNotifier<List<PostModel>?> {
  @override
  FutureOr<List<PostModel>?> build() async {
    final repository = ref.read(postRepositoryNotifier);
    return await repository.fetchPost();
  }

  Future fetchPosts() async {
    state = AsyncLoading();
    final repository = ref.read(postRepositoryNotifier);
    state = await AsyncValue.guard(() async {
      final response = await repository.fetchPost();
      return response;
    });
  }
}
