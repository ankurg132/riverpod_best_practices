import 'package:flutter/material.dart';
import 'package:flutter_riverpod_demo/posts/model/post_model.dart';

class BlogDataCard extends StatelessWidget {
  final PostModel? data;
  const BlogDataCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(data?.title ?? ""), Text(data?.body ?? "")],
      ),
    );
  }
}
