import 'package:k_chart_plus/k_chart_plus.dart';

class ChartState {
  final bool isLoading;
  final String goldType;
  final String timeframe;
  final bool isCandle;
  final List<KLineEntity> candles;

  ChartState({
    required this.isLoading,
    required this.goldType,
    required this.timeframe,
    required this.isCandle,
    required this.candles,
  });

  factory ChartState.initial() => ChartState(
    isLoading: false,
    goldType: "SJC",
    timeframe: "1h",
    isCandle: true,
    candles: [],
  );

  ChartState copyWith({
    bool? isLoading,
    String? goldType,
    String? timeframe,
    bool? isCandle,
    List<KLineEntity>? candles,
  }) {
    return ChartState(
      isLoading: isLoading ?? this.isLoading,
      goldType: goldType ?? this.goldType,
      timeframe: timeframe ?? this.timeframe,
      isCandle: isCandle ?? this.isCandle,
      candles: candles ?? this.candles,
    );
  }
}
