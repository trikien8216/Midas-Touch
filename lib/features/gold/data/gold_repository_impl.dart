import 'gold_api.dart';
import 'gold_model.dart';
import 'gold_repository.dart';

class GoldRepositoryImpl implements GoldRepository {
  final GoldApi api;

  GoldRepositoryImpl(this.api);

  @override
  Future<GoldPriceResponse> fetchGoldPrice({
    required String clientId,
    required String token,
    int? limit,
  }) async {
    try {
      final response = await api.getGoldPrice(
        clientId: clientId,
        token: token,
        limit: limit,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
