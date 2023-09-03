import 'exchange_rate.dart';

class ExchangeRateList {
  final List<ExchangeRate> rates;

  ExchangeRateList({required this.rates});

  factory ExchangeRateList.fromJson(List<dynamic> json) {
    List<ExchangeRate> rates = json.map((i) => ExchangeRate.fromJson(i)).toList();
    return ExchangeRateList(rates: rates);
  }
}