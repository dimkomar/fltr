import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'abstract_currency_repository.dart';
import 'models/exchange_rate.dart';

class CurrencyRepository implements AbstractCurrencyRepository {
  CurrencyRepository({
    required this.dio,
    required this.exchangeRateBox,
  });

  final Dio dio;
  final Box<ExchangeRate> exchangeRateBox;

  @override
  Future<List<ExchangeRate>> getCurrenciesList() async {
    var rateList = <ExchangeRate>[];
    try {
      rateList = await _fetchExchangeRateFromAPI();
      final rateMap = rateList.asMap().map((_, rate) => MapEntry(rate.name, rate));
      await exchangeRateBox.putAll(rateMap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return exchangeRateBox.values.toList();
    }

    return rateList;
  }

  Future<List<ExchangeRate>> _fetchExchangeRateFromAPI() async {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    final response = await dio.get(
        'https://developerhub.alfabank.by:8273/partner/1.0.1/public/nationalRates?currencyCode=978,985,643,840');

    final data = response.data as Map<String, dynamic>;
    final rates = data['rates'] as List;
    final rateList = rates.map((e) => ExchangeRate.fromJson(e)).toList();
    return rateList;
  }
}
