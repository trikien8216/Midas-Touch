import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

import '../cubit/chart_cubit.dart';
import '../cubit/chart_state.dart';
import '../data/chart_api.dart';
import '../data/chart_repository.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChartCubit(ChartRepository(ChartApi()))..load('1h'),
      child: _ChartView(),
    );
  }
}

class _ChartView extends StatelessWidget {
  final List<String> timeframes = ["1m", "5m", "15m", "1h", "4h", "1D", "1W"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Midas Touch Chart"), centerTitle: true),
      body: BlocBuilder<ChartCubit, ChartState>(
        builder: (context, state) {
          final cubit = context.read<ChartCubit>();

          return Column(
            children: [
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemCount: timeframes.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8),
                  itemBuilder: (_, index) {
                    final tf = timeframes[index];
                    final isActive = tf == state?.timeframe;

                    return GestureDetector(
                      onTap: () => cubit.load(tf),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.amber[700]
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            tf,
                            style: TextStyle(
                              color: isActive ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: state.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : KChartWidget(
                        state.candles,
                        ChartStyle(),
                        ChartColors(),
                        isLine: false,
                        isTrendLine: false,
                        // mainState: MainState.MA,
                        // volState: VolState.VOL,
                        showNowPrice: true,
                        timeFormat: TimeFormat.YEAR_MONTH_DAY,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
