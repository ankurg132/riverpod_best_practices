import 'package:dio/dio.dart';
import 'package:flutter_riverpod_demo/common/api_urls.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late Dio dio;
  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(requestBody: true, requestHeader: true),
    );
  }
  Future<Response> get(String url) async {
    final response = await dio.get(url);
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> params) async {
    final response = await dio.post(url, data: params);
    return response;
  }
}
