import 'package:dio/dio.dart';
import 'auth_api.dart';
import 'auth_model.dart';
import 'auth_repository.dart';
import '../../../core/error/app_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl(this.authApi);

  @override
  Future<AuthModel> getFeedToken({
    required String clientId,
    int? ttl,
  }) async {
    try {
      final response = await authApi.getFeedToken(
        clientId: clientId,
        ttl: ttl,
      );

      // API trả về 201 Created khi thành công
      if (response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        
        // Kiểm tra success field
        if (responseData['success'] == true && responseData['data'] != null) {
          return AuthModel.fromJson(responseData['data'] as Map<String, dynamic>);
        } else {
          final errorMessage = responseData['message'] as String? ?? 
                              'Failed to get token';
          throw AppException(
            message: errorMessage,
            statusCode: response.statusCode,
          );
        }
      } else {
        final responseData = response.data as Map<String, dynamic>?;
        final errorMessage = responseData?['message'] as String? ?? 
                            'Failed to get token: ${response.statusCode}';
        throw AppException(
          message: errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      // Xử lý error response từ API
      if (e.response?.data != null) {
        final errorData = e.response!.data as Map<String, dynamic>?;
        final errorMessage = errorData?['message'] as String? ?? 
                            e.message ?? 
                            'Network error occurred';
        throw AppException(
          message: errorMessage,
          statusCode: e.response?.statusCode,
        );
      }
      
      throw AppException(
        message: e.message ?? 'Network error occurred',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(message: e.toString());
    }
  }
}
