import 'package:dio/dio.dart';
import '../constants/endpoints.dart';
import 'token_interceptor.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Thêm TokenInterceptor để tự động thêm token vào requests
    dio.interceptors.add(TokenInterceptor());

    return dio;
  }
}
