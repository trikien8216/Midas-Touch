import 'package:dio/dio.dart';
import '../core/network/dio_config.dart';
import '../features/auth/data/auth_api.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/auth/data/auth_repository_impl.dart';
import '../features/auth/cubit/auth_cubit.dart';
import '../features/gold/data/gold_api.dart';
import '../features/gold/data/gold_repository.dart';
import '../features/gold/data/gold_repository_impl.dart';
import '../features/gold/cubit/gold_cubit.dart';

class DependencyInjection {
  // Dio instance
  static Dio? _dio;

  static Dio get dio {
    _dio ??= DioConfig.createDio();
    return _dio!;
  }

  // Auth
  static AuthApi get authApi => AuthApi(dio);
  static AuthRepository get authRepository => AuthRepositoryImpl(authApi);
  static AuthCubit get authCubit => AuthCubit(authRepository);

  // Gold
  static GoldApi get goldApi => GoldApi(dio);
  static GoldRepository get goldRepository => GoldRepositoryImpl(goldApi);
  static GoldCubit get goldCubit => GoldCubit(goldRepository);
}
