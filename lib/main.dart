import 'dart:async';

import 'package:crypto_coins_list/repositories/currencies/currencies.dart';
import 'package:crypto_coins_list/repositories/data_providers/exchange_rate_manager.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'currency_app.dart';
import 'firebase_options.dart';

void main() async {
  //firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker is ready');

  await Hive.initFlutter();
  Hive.registerAdapter(ExchangeRateAdapter());
  Hive.registerAdapter(ExchangeRateListAdapter());

  final exchangeRateBox = await Hive.openBox<ExchangeRate>('exchange_rate_box');

  GetIt.I.registerLazySingleton<AbstractCurrencyRepository>(
      () => CurrencyRepository(dio: Dio(), exchangeRateBox: exchangeRateBox));


  //GetIt.I.registerSingleton<ExchangeRateManager>(ExchangeRateManager());


  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
     printResponseData: false,
    )
  ));

  Bloc.observer = TalkerBlocObserver(talker: talker);

  FlutterError.onError = (details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };

  runZonedGuarded(
          () => runApp(const MyApp()), (error, stack) => GetIt.I<Talker>().handle(error, stack)
  );
}
