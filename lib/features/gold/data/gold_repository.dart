// lib/features/gold/domain/repositories/gold_repository.dart

import 'gold_model.dart';

abstract class GoldRepository {
  Future<GoldPriceResponse> fetchGoldPrice({
    required String clientId,
    required String token,
    int? limit,
  });
}
