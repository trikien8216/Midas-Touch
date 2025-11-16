import '../data/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> getFeedToken({
    required String clientId,
    int? ttl,
  });
}
