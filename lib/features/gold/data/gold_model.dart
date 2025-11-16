
class GoldPriceResponse {
  final bool success;
  final int statusCode;
  final String code;
  final String message;
  final GoldPriceData data;
  final Meta meta;

  GoldPriceResponse({
    required this.success,
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory GoldPriceResponse.fromJson(Map<String, dynamic> json) {
    return GoldPriceResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      data: GoldPriceData.fromJson(json['data'] ?? {}),
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status_code': statusCode,
      'code': code,
      'message': message,
      'data': data.toJson(),
      'meta': meta.toJson(),
    };
  }
}

class GoldPriceData {
  final List<GoldItem> items;

  GoldPriceData({required this.items});

  factory GoldPriceData.fromJson(Map<String, dynamic> json) {
    return GoldPriceData(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => GoldItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((e) => e.toJson()).toList()};
  }
}

class GoldItem {
  final int id;
  final String datetime;
  final int timestamp;
  final GoldDetail buy;
  final GoldDetail sell;
  final GoldRaw raw;

  GoldItem({
    required this.id,
    required this.datetime,
    required this.timestamp,
    required this.buy,
    required this.sell,
    required this.raw,
  });

  factory GoldItem.fromJson(Map<String, dynamic> json) {
    return GoldItem(
      id: json['id'] ?? 0,
      datetime: json['datetime'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      buy: GoldDetail.fromJson(json['buy'] ?? {}),
      sell: GoldDetail.fromJson(json['sell'] ?? {}),
      raw: GoldRaw.fromJson(json['raw'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'datetime': datetime,
      'timestamp': timestamp,
      'buy': buy.toJson(),
      'sell': sell.toJson(),
      'raw': raw.toJson(),
    };
  }
}

class GoldDetail {
  final String sjc1c;
  final String sjc1l;
  final String sjc5c;
  final String nhan1c;
  final String nutrang75;
  final String nutrang99;
  final String nutrang9999;

  GoldDetail({
    required this.sjc1c,
    required this.sjc1l,
    required this.sjc5c,
    required this.nhan1c,
    required this.nutrang75,
    required this.nutrang99,
    required this.nutrang9999,
  });

  factory GoldDetail.fromJson(Map<String, dynamic> json) {
    return GoldDetail(
      sjc1c: json['sjc_1c'] ?? '',
      sjc1l: json['sjc_1l'] ?? '',
      sjc5c: json['sjc_5c'] ?? '',
      nhan1c: json['nhan_1c'] ?? '',
      nutrang75: json['nutrang_75'] ?? '',
      nutrang99: json['nutrang_99'] ?? '',
      nutrang9999: json['nutrang_9999'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sjc_1c': sjc1c,
      'sjc_1l': sjc1l,
      'sjc_5c': sjc5c,
      'nhan_1c': nhan1c,
      'nutrang_75': nutrang75,
      'nutrang_99': nutrang99,
      'nutrang_9999': nutrang9999,
    };
  }
}

class GoldRaw {
  final String buy1c;
  final String buy1l;
  final String buy5c;
  final String buyNhan1c;
  final String buyNutrang75;
  final String buyNutrang99;
  final String buyNutrang9999;
  final String sell1c;
  final String sell1l;
  final String sell5c;
  final String sellNhan1c;
  final String sellNutrang75;
  final String sellNutrang99;
  final String sellNutrang9999;
  final String datetime;

  GoldRaw({
    required this.buy1c,
    required this.buy1l,
    required this.buy5c,
    required this.buyNhan1c,
    required this.buyNutrang75,
    required this.buyNutrang99,
    required this.buyNutrang9999,
    required this.sell1c,
    required this.sell1l,
    required this.sell5c,
    required this.sellNhan1c,
    required this.sellNutrang75,
    required this.sellNutrang99,
    required this.sellNutrang9999,
    required this.datetime,
  });

  factory GoldRaw.fromJson(Map<String, dynamic> json) {
    return GoldRaw(
      buy1c: json['buy_1c'] ?? '',
      buy1l: json['buy_1l'] ?? '',
      buy5c: json['buy_5c'] ?? '',
      buyNhan1c: json['buy_nhan1c'] ?? '',
      buyNutrang75: json['buy_nutrang_75'] ?? '',
      buyNutrang99: json['buy_nutrang_99'] ?? '',
      buyNutrang9999: json['buy_nutrang_9999'] ?? '',
      sell1c: json['sell_1c'] ?? '',
      sell1l: json['sell_1l'] ?? '',
      sell5c: json['sell_5c'] ?? '',
      sellNhan1c: json['sell_nhan1c'] ?? '',
      sellNutrang75: json['sell_nutrang_75'] ?? '',
      sellNutrang99: json['sell_nutrang_99'] ?? '',
      sellNutrang9999: json['sell_nutrang_9999'] ?? '',
      datetime: json['datetime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buy_1c': buy1c,
      'buy_1l': buy1l,
      'buy_5c': buy5c,
      'buy_nhan1c': buyNhan1c,
      'buy_nutrang_75': buyNutrang75,
      'buy_nutrang_99': buyNutrang99,
      'buy_nutrang_9999': buyNutrang9999,
      'sell_1c': sell1c,
      'sell_1l': sell1l,
      'sell_5c': sell5c,
      'sell_nhan1c': sellNhan1c,
      'sell_nutrang_75': sellNutrang75,
      'sell_nutrang_99': sellNutrang99,
      'sell_nutrang_9999': sellNutrang9999,
      'datetime': datetime,
    };
  }
}

class Meta {
  final int limit;
  final int count;

  Meta({required this.limit, required this.count});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      limit: json['limit'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'count': count,
    };
  }
}
