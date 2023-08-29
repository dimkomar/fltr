
import 'package:crypto_coins_list/repositories/currencies/currencies.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'currency_app.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCurrencyRepository>(() => CurrencyRepository(dio: Dio()));
  runApp(const MyApp());
}





