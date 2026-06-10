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
        data: (post) {
          if (post.data?.isNotEmpty ?? false) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent * 0.9) {
                  if (postNotifier.value?.nextPostLoading == false) {
                    // Safe to read and call here!
                    ref
                        .read(postNotifierProvider.notifier)
                        .fetchPaginatedPosts();
                  }
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () =>
                    ref.watch(postNotifierProvider.notifier).fetchPosts(),
                child: ListView.builder(
                  itemCount: (post.data?.length ?? 0) + 1,
                  itemBuilder: (context, index) {
                    if (index == post.data?.length) {
                      if (post.nextPostLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return SizedBox.square();
                      }
                    }
                    return BlogDataCard(data: post.data?[index]);
                  },
                ),
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
