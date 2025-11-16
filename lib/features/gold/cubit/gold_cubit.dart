// lib/features/gold/presentation/cubit/gold_cubit.dart
import 'package:bloc/bloc.dart';
import '../data/gold_repository.dart';
import 'gold_state.dart';

class GoldCubit extends Cubit<GoldState> {
  final GoldRepository repository;

  GoldCubit(this.repository) : super(GoldInitial());

  Future<void> loadGoldPrice({
    required String clientId,
    required String token,
    int? limit,
  }) async {
    emit(GoldLoading());
    try {
      final response = await repository.fetchGoldPrice(
        clientId: clientId,
        token: token,
        limit: limit,
      );
      emit(GoldLoaded(response.data.items));
    } catch (e) {
      emit(GoldError(e.toString()));
    }
  }
}
