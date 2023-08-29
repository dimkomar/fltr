import 'package:crypto_coins_list/routes/routes.dart';
import 'package:crypto_coins_list/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto currency',
      theme: darkTheme,
      routes: routes,
    );
  }
}