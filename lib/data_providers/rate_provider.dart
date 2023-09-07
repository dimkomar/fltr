

import 'package:hive/hive.dart';

import '../repositories/currencies/models/exchange_rate.dart';

class RateProvider {
  final Box<ExchangeRate> exchangeRateBox;

  late final String currencyName;


  RateProvider({
    required this.exchangeRateBox,
  });



}