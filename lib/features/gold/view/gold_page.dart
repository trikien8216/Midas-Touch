import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_chart_plus/k_chart_plus.dart';
import 'dart:math' as math;
import '../../gold/cubit/gold_cubit.dart';
import '../../gold/cubit/gold_state.dart';
import '../../gold/data/gold_model.dart';
import '../../../config/data.dart';

class GoldPage extends StatefulWidget {
  const GoldPage({super.key});

  @override
  State<GoldPage> createState() => _GoldPageState();
}

class _GoldPageState extends State<GoldPage> {
  final List<String> _ranges = const ['24H', '1W', '1M', '3M', '6M', '1Y', 'All'];
  String _selectedRange = '24H';
  String _selectedCurrency = 'CAD';
  final List<String> _sides = const ['Buy', 'Sell'];
  String _selectedSide = 'Buy';
  final Map<String, String> _typeLabels = const {
    'all': 'Tất cả',
    'sjc1c': 'SJC 1c',
    'sjc1l': 'SJC 1l',
    'sjc5c': 'SJC 5c',
    'nhan1c': 'Nhẫn 1c',
    'nutrang75': 'Nữ trang 75',
    'nutrang99': 'Nữ trang 99',
    'nutrang9999': 'Nữ trang 9999',
  };
  String _selectedType = 'all';

  late final List<GoldItem> _sampleItems;
  List<KLineEntity> _klineData = [];

  @override
  void initState() {
    super.initState();
    final response = GoldPriceResponse.fromJson(jsonData);
    _sampleItems = response.data.items;
    _klineData = _convertToKLineData(_sampleItems, _selectedType);
    if (_klineData.isNotEmpty) DataUtil.calculate(_klineData);
  }

  Widget _buildChip({
    required String label,
    required bool selected,
    required Color color,
    required VoidCallback onSelected,
    IconData? icon,
  }) {
    final Color selectedBg = color.withOpacity(0.12);
    final Color unselectedBorder = Colors.grey.shade300;
    final Color fg = selected ? color : Colors.black87;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          color: fg,
        ),
      ),
      // avatar: icon != null
      //     ? Icon(
      //         icon,
      //         size: 16,
      //         color: Colors.black87,
      //       )
      //     : null,
      selected: selected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.white,
      selectedColor: selectedBg,
      side: BorderSide(color: selected ? color : unselectedBorder),
      shape: const StadiumBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gold')),
      body: BlocBuilder<GoldCubit, GoldState>(
        builder: (context, state) {
          final items = state is GoldLoaded && state.items.isNotEmpty ? state.items : _sampleItems;
          final kline = state is GoldLoaded && state.items.isNotEmpty ? _convertToKLineData(items, _selectedType) : _klineData;
          if (kline.isNotEmpty) DataUtil.calculate(kline);

          final latest = items.isNotEmpty ? items.last : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _rangeChips(),
                      const SizedBox(height: 8),
                      _sideChips(),
                      const SizedBox(height: 8),
                      _typeChips(),
                      const SizedBox(height: 12),
                      Expanded(child: _chartCard(kline)),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 12),
                  child: _walletsHorizontalList(latest),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Horizontal wallets list per gold type from latest item
  Widget _walletsHorizontalList(GoldItem? last) {
    if (last == null) return const SizedBox.shrink();
    final allTypes = <_TypeCardInfo>[
      _TypeCardInfo('sjc1c', _typeLabels['sjc1c']!, last.buy.sjc1c, last.sell.sjc1c),
      _TypeCardInfo('sjc1l', _typeLabels['sjc1l']!, last.buy.sjc1l, last.sell.sjc1l),
      _TypeCardInfo('sjc5c', _typeLabels['sjc5c']!, last.buy.sjc5c, last.sell.sjc5c),
      _TypeCardInfo('nhan1c', _typeLabels['nhan1c']!, last.buy.nhan1c, last.sell.nhan1c),
      _TypeCardInfo('nutrang75', _typeLabels['nutrang75']!, last.buy.nutrang75, last.sell.nutrang75),
      _TypeCardInfo('nutrang99', _typeLabels['nutrang99']!, last.buy.nutrang99, last.sell.nutrang99),
      _TypeCardInfo('nutrang9999', _typeLabels['nutrang9999']!, last.buy.nutrang9999, last.sell.nutrang9999),
    ];
    final types = _selectedType == 'all' ? allTypes : allTypes.where((t) => t.key == _selectedType).toList();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      itemCount: types.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final t = types[index];
        return SizedBox(
          width: 200,
          child: _walletCard(
            title: t.title,
            subtitle: _selectedSide,
            value: _selectedSide == 'Buy' ? _shortVN(t.buy) : _shortVN(t.sell),
            equivalent: '',
            gradient: index.isEven
                ? const [Color(0xFFFFF3C4), Color(0xFFFFE19E)]
                : const [Color(0xFFF2F5FA), Color(0xFFE7EDF6)],
          ),
        );
      },
    );
  }

  Widget _walletCard({required String title, required String subtitle, required String value, required String equivalent, required List<Color> gradient}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 12, backgroundColor: Colors.black87, child: Icon(Icons.emoji_events, size: 14, color: Colors.white)),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 6),
          _pill(subtitle, subtitle == 'Buy' ? Colors.green.shade600 : Colors.red.shade600),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          if (equivalent.isNotEmpty)
            Text(equivalent, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _currencySelector() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.flag, size: 18, color: Colors.red),
            const SizedBox(width: 6),
            Text(_selectedCurrency, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _chartCard(List<KLineEntity> kline) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
      child: kline.isEmpty
          ? const Center(child: Text('No data'))
          : KChartWidget(
              kline,
              ChartStyle(),
              ChartColors(),
              isLine: true,
              volHidden: true,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              isTrendLine: false,
              onLoadMore: (bool a) {},
            ),
    );
  }

  Widget _rangeChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _ranges.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = _ranges[index];
          final selected = _selectedRange == label;
          return _buildChip(
            label: label,
            selected: selected,
            color: Colors.amber.shade700,
            onSelected: () => setState(() => _selectedRange = label),
            icon: Icons.timeline,
          );
        },
      ),
    );
  }

  Widget _sideChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: _sides.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = _sides[index];
          final selected = _selectedSide == label;
          final color = label == 'Buy' ? Colors.green.shade700 : Colors.red.shade700;
          final icon = label == 'Buy' ? Icons.trending_up : Icons.trending_down;
          return _buildChip(
            label: label,
            selected: selected,
            color: color,
            onSelected: () => setState(() => _selectedSide = label),
            icon: icon,
          );
        },
      ),
    );
  }

  Widget _typeChips() {
    final entries = _typeLabels.entries.toList();
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final key = entries[index].key;
          final label = entries[index].value;
          final selected = _selectedType == key;
          return _buildChip(
            label: label,
            selected: selected,
            color: Colors.blue.shade700,
            onSelected: () => setState(() {
              _selectedType = key;
              _klineData = _convertToKLineData(
                (context.read<GoldCubit>().state is GoldLoaded)
                    ? (context.read<GoldCubit>().state as GoldLoaded).items
                    : _sampleItems,
                _selectedType,
              );
            }),
            icon: Icons.stars,
          );
        },
      ),
    );
  }

  List<KLineEntity> _convertToKLineData(List<GoldItem> items, String typeKey) {
    final List<KLineEntity> klines = [];
    for (int i = 0; i < items.length; i++) {
      final it = items[i];
      final buyStr = _valueByType(it.buy, typeKey);
      final sellStr = _valueByType(it.sell, typeKey);
      final buy = double.tryParse(buyStr) ?? 0.0;
      final sell = double.tryParse(sellStr) ?? buy;
      final high = math.max(buy, sell) * 1.002;
      final low = math.min(buy, sell) * 0.998;
      final map = {
        'open': buy,
        'high': high,
        'low': low,
        'close': sell,
        'vol': 1000.0,
        'amount': 1000000.0,
        'time': it.timestamp,
      };
      klines.add(KLineEntity.fromJson(map));
    }
    return klines;
  }

  String _formatCurrency(double v) {
    if (v == 0) return '\$ 0.00';
    return '\$ ' + v.toStringAsFixed(2);
  }

  String _shortVN(String raw) {
    final value = double.tryParse(raw) ?? 0;
    if (value >= 1e9) {
      return (value / 1e9).toStringAsFixed(2) + 'B₫';
    } else if (value >= 1e6) {
      return (value / 1e6).toStringAsFixed(2) + 'M₫';
    } else if (value >= 1e3) {
      return _thousands(value.toInt()) + '₫';
    }
    return value.toStringAsFixed(0) + '₫';
  }

  String _thousands(int n) {
    final s = n.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final fromRight = s.length - i;
      buffer.write(s[i]);
      if (fromRight > 1 && fromRight % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}

class _TypeCardInfo {
  final String key;
  final String title;
  final String buy;
  final String sell;
  _TypeCardInfo(this.key, this.title, this.buy, this.sell);
}

String _valueByType(GoldDetail detail, String typeKey) {
  switch (typeKey) {
    case 'sjc1c':
      return detail.sjc1c;
    case 'sjc1l':
      return detail.sjc1l;
    case 'sjc5c':
      return detail.sjc5c;
    case 'nhan1c':
      return detail.nhan1c;
    case 'nutrang75':
      return detail.nutrang75;
    case 'nutrang99':
      return detail.nutrang99;
    case 'nutrang9999':
      return detail.nutrang9999;
    case 'all':
    default:
      // default back to sjc1c for chart when "all"
      return detail.sjc1c;
  }
}
