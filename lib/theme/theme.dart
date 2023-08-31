import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
    scaffoldBackgroundColor: Color.fromARGB(51, 51, 51, 100),
    listTileTheme: ListTileThemeData(iconColor: Colors.white),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(33, 33, 33, 100),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 26)),
    useMaterial3: true,
    textTheme: TextTheme(
        bodyMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        labelMedium: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w700,
            fontSize: 14)));
