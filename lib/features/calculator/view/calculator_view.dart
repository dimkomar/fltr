import 'package:flutter/material.dart';

class CalculatorBottomSheet extends StatefulWidget {
  final Function(String) onResult;

  CalculatorBottomSheet({required this.onResult});

  @override
  _CalculatorBottomSheetState createState() => _CalculatorBottomSheetState();
}

class _CalculatorBottomSheetState extends State<CalculatorBottomSheet> {
  String currentInput = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey, // задаём цвет фона
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Устанавливаем минимальное вертикальное пространство
        crossAxisAlignment: CrossAxisAlignment.stretch, // Растягиваем детей по ширине
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentInput,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          _calculatorRow(["AC", "÷", "×", "⌫"]),
          _calculatorRow(["7", "8", "9", "-"]),
          _calculatorRow(["4", "5", "6", "+"]),
          _calculatorRow(["1", "2", "3", "="]),
          _calculatorRow(["0", ".", "V", "="]),
        ],
      ),
    );
  }

  Widget _calculatorRow(List<String> values) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Растягиваем детей по ширине
        children: values.map((value) {
          return _calculatorButton(value, () {
            setState(() {
              currentInput += value;
            });
          });
        }).toList(),
      ),
    );
  }

  Widget _calculatorButton(String label, VoidCallback onTap, {bool isLong = false}) {
    return Expanded(
      flex: isLong ? 2 : 1,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(label, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: EdgeInsets.zero, // Здесь мы устанавливаем отступы в ноль
          primary: Colors.black,
        ),
      ),
    );
  }
}