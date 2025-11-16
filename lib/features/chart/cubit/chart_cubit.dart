import 'package:flutter_bloc/flutter_bloc.dart';
import 'chart_state.dart';
import '../data/chart_repository.dart';

class ChartCubit extends Cubit<ChartState> {
  final ChartRepository repo;

  ChartCubit(this.repo) : super(ChartState.initial());

  Future<void> load(String timeframe) async {
    emit(state.copyWith(isLoading: true));

    final data = await repo.getCandles(timeframe);

    emit(state.copyWith(
      isLoading: false,
      candles: data,
      timeframe: timeframe,
    ));
  }
}
