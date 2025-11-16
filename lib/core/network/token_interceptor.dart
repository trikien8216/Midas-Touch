import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/endpoints.dart';

class TokenInterceptor extends Interceptor {
  static const String _tokenKey = 'feed_token';
  static const String _clientIdKey = 'client_id';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Endpoint lấy token không cần Authorization header (public endpoint)
    // Kiểm tra nếu path chứa 'feed/token' thì skip thêm token
    final isTokenEndpoint = options.path.contains('feed/token') ||
        options.uri.path.contains('feed/token');

    // Endpoint gold feed (/feed) không cần header vì token được gửi trong body
    // Nhưng phải loại trừ endpoint /feed/token
    final isGoldFeedEndpoint = (options.path.contains('/feed') ||
            options.uri.path.contains('/feed')) &&
        !isTokenEndpoint;

    // Chỉ thêm header X-API-KEY cho các endpoint khác (nếu cần)
    if (!isTokenEndpoint && !isGoldFeedEndpoint) {
      // Lấy token từ SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);

      // Thêm token vào header X-API-KEY (API yêu cầu header này)
      if (token != null) {
        options.headers['X-API-KEY'] = token;
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Xử lý lỗi 401 Unauthorized - token hết hạn
    if (err.response?.statusCode == 401) {
      // Có thể tự động refresh token ở đây
    }

    handler.next(err);
  }

  // Helper method để lưu token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Helper method để xóa token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Helper method để lấy token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Helper method để lưu clientId
  static Future<void> saveClientId(String clientId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_clientIdKey, clientId);
  }

  // Helper method để xóa clientId
  static Future<void> clearClientId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_clientIdKey);
  }

  // Helper method để lấy clientId
  static Future<String?> getClientId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_clientIdKey);
  }

  // Helper method để clear all (token + clientId)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_clientIdKey);
  }
}
