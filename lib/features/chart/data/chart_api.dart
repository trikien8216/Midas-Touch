import 'dart:convert';

class ChartApi {
  Future<List<Map<String, dynamic>>> fetchCandles(String timeframe) async {
    await Future.delayed(Duration(milliseconds: 400)); // fake delay

    // Fake JSON mẫu
    final jsonResponse = '''
    [
      {"timestamp": 1731735600000,"open":2345.5,"high":2360.2,"low":2330.1,"close":2350.8,"volume":120.5},
      {"timestamp": 1731735660000,"open":2350.8,"high":2355.9,"low":2340.2,"close":2348.3,"volume":98.2},
      {"timestamp": 1731735720000,"open":2348.3,"high":2365.5,"low":2345.1,"close":2363.4,"volume":150.1},
      {"timestamp": 1731735780000,"open":2363.4,"high":2368.8,"low":2358.2,"close":2360.1,"volume":110.9},
      {"timestamp": 1731735840000,"open":2360.1,"high":2362.7,"low":2350.2,"close":2355.6,"volume":95.0},
      {"timestamp": 1731735900000,"open":2355.6,"high":2370.1,"low":2354.4,"close":2368.9,"volume":180.3},
      {"timestamp": 1731735960000,"open":2368.9,"high":2375.2,"low":2362.8,"close":2370.5,"volume":140.7}
    ]
    ''';

    return List<Map<String, dynamic>>.from(json.decode(jsonResponse));
  }
}
