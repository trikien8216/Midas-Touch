import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<Response> getFeedToken({
    required String clientId,
    int? ttl,
  }) async {
    final data = <String, dynamic>{
      'client_id': clientId,
    };

    if (ttl != null) {
      data['ttl'] = ttl;
    }

    return dio.post(
      Endpoints.feedToken,
      data: data,
    );
  }
}
