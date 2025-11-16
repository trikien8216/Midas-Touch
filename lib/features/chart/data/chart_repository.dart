import 'package:k_chart_plus/k_chart_plus.dart';
import '../data/chart_api.dart';

class ChartRepository {
  final ChartApi api;

  ChartRepository(this.api);

  Future<List<KLineEntity>> getCandles(String timeframe) async {
    final raw = await api.fetchCandles(timeframe);
    return raw.map((e) => KLineEntity.fromJson(e)).toList();
  }
}
