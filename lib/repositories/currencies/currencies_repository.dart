import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'abstract_currency_repository.dart';
import 'models/rate.dart';

class CurrencyRepository implements AbstractCurrencyRepository {

  CurrencyRepository({
    required this.dio,
  });

  final Dio dio;


  @override
  Future<List<Rate>> getCurrenciesList() async {
    // Configure the HttpClient to accept self-signed certificates
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    // Make a request
    final response = await dio.get(
        'https://developerhub.alfabank.by:8273/partner/1.0.1/public/nationalRates?currencyCode=978,985,643,840');

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final rates = data['rates'] as List;
      final rateList = rates.map((e) => Rate.fromJson(e)).toList();
      print(rates);

      return rateList;
    } else {
      throw Exception('Failed to load currencies');
    }
  }

}
