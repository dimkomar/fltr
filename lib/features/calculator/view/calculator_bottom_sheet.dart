import 'package:flutter/material.dart';
import 'calculator_logic.dart'; // Ensure you have the 'calculator_logic.dart' in the same directory or adjust the path accordingly.

class CalculatorBottomSheet extends StatefulWidget {
  final Function(String) onResult;

  CalculatorBottomSheet({required this.onResult});

  @override
  _CalculatorBottomSheetState createState() => _CalculatorBottomSheetState();
}

class _CalculatorBottomSheetState extends State<CalculatorBottomSheet> {
  final CalculatorLogic _logic = CalculatorLogic();


  final buttonTextStyle = TextStyle(color: Colors.white, fontSize: 20.0);

  Color _buttonColor(String label) {
    switch (label) {
      case "AC":
        return Colors.red;
      case "÷":
      case "×":
      case "-":
      case "+":
        return Colors.orange;
      case "=":
        return Colors.green;
      case "⌫":
        return Colors.blueGrey;
      case "V":
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  final buttonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    padding: EdgeInsets.zero,
    primary: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _logic.currentInput,
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
          _calculatorButtonRow(["AC", "÷", "×", "⌫"]),
          _calculatorButtonRow(["7", "8", "9", "-"]),
          _calculatorButtonRow(["4", "5", "6", "+"]),
          _calculatorButtonRow(["1", "2", "3", "="]),
          _calculatorButtonRow(["0", ".", "V", "="]),
        ],
      ),
    );
  }


  Widget _calculatorButtonRow(List<String> values) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((value) {
          return _calculatorButton(value);
        }).toList(),
      ),
    );
  }

  Widget _calculatorButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          _handleButtonPress(label);
        },
        child: Text(label, style: buttonTextStyle),
        style: ElevatedButton.styleFrom(
          primary: _buttonColor(label), // Используется новый метод для установки цвета
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "=") {
        String result = _logic.calculateResult();
        widget.onResult(result);
      } else if (value == "AC") {
        _logic.clearCalculator();
      } else if (value == "⌫") {
        _logic.backspace();
      } else {
        _logic.currentInput += value;
      }
    });
  }
}