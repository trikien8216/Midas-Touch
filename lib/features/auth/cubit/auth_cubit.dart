import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_repository.dart';
import '../../../core/network/token_interceptor.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(const AuthInitial());

  Future<void> getFeedToken({
    required String clientId,
    int? ttl,
  }) async {
    emit(const AuthLoading());

    try {
      final authModel = await authRepository.getFeedToken(
        clientId: clientId,
        ttl: ttl,
      );

      // Lưu token và clientId vào SharedPreferences
      await TokenInterceptor.saveToken(authModel.token);
      await TokenInterceptor.saveClientId(clientId);
      
      emit(AuthSuccess(
        clientId: clientId,
        token: authModel.token,
        expiresAt: authModel.expiresAt,
        expiresTimestamp: authModel.expiresTimestamp,
        ttlMinutes: authModel.ttlMinutes,
      ));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
