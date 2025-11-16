// lib/features/gold/data/datasources/gold_api.dart
import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../../../core/network/token_interceptor.dart';
import 'gold_model.dart';

class GoldApi {
  final Dio dio;

  GoldApi(this.dio) {
    dio.interceptors.add(TokenInterceptor()); // nếu có
  }

  Future<GoldPriceResponse> getGoldPrice({
    required String clientId,
    required String token,
    int? limit,
  }) async {
    final data = <String, dynamic>{
      'client_id': clientId,
      'token': token,
      if (limit != null) 'limit': limit,
    };

    final response = await dio.post(
      Endpoints.goldPrice,
      data: data,
    );

    return GoldPriceResponse.fromJson(response.data);
  }
}
