import 'package:hive/hive.dart';

import 'exchange_rate.dart';

part 'exchange_rate_list.g.dart';

@HiveType(typeId: 2) // Using a different typeId than ExchangeRate
class ExchangeRateList {
  @HiveField(0)
  final List<ExchangeRate> rates;

  ExchangeRateList({required this.rates});

  factory ExchangeRateList.fromJson(List<dynamic> json) {
    List<ExchangeRate> rates = json.map((i) => ExchangeRate.fromJson(i)).toList();
    return ExchangeRateList(rates: rates);
  }
}