import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final double initialValue;

  CalculatorScreen({required this.initialValue});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late double currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  // Здесь ваш код калькулятора

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Основной код для интерфейса калькулятора
    );
  }
}