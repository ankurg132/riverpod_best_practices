import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/common/api_client.dart';
import 'package:flutter_riverpod_demo/common/api_urls.dart';
import 'package:flutter_riverpod_demo/posts/model/post_model.dart';

final postRepositoryNotifier = Provider<PostRepository>(
  (ref) => PostRepository(),
);

class PostRepository {
  Future<List<PostModel>?> fetchPost() async {
    final response = await ApiClient().get(ApiUrls.postsUrl);
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data;
      return list.map((json) => PostModel.fromJson(json)).toList();
    }
    return null;
  }
}
