import 'package:flutter_riverpod_demo/common/params.dart';

class ApiUrls {
  static const baseUrl = "https://jsonplaceholder.typicode.com";
  static const postsUrl = "/posts?_limit=${ApiParams.pageLimit}";
}
