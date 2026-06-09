import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/posts/notifier/post_notifier.dart';
import 'package:flutter_riverpod_demo/posts/view/widgets/blog_data_card.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postNotifier = ref.watch(postNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: postNotifier.when(
        data: (data) {
          if (data?.isNotEmpty ?? false) {
            return RefreshIndicator(
              onRefresh: () =>
                  ref.watch(postNotifierProvider.notifier).fetchPosts(),
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) =>
                    BlogDataCard(data: data?[index]),
              ),
            );
          } else {
            return Container();
          }
        },
        error: (error, stackTrace) => Center(child: Text("Error")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
