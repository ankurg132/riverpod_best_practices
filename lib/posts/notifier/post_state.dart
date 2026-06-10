// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod_demo/posts/model/post_model.dart';

class PostState {
  final List<PostModel>? data;
  final int currentPage;
  final bool hasMoreData;
  final bool nextPostLoading;

  PostState({required this.data, required this.currentPage, required this.hasMoreData, this.nextPostLoading = false});
  
  

  PostState copyWith({
    List<PostModel>? data,
    int? currentPage,
    bool? hasMoreData,
    bool? nextPostLoading,
  }) {
    return PostState(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      nextPostLoading: nextPostLoading ?? this.nextPostLoading,
    );
  }
}
