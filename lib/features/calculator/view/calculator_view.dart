
import 'package:flutter/material.dart';


class CalculatorBottomSheet extends StatefulWidget {
  final Function(String) onResult;

  CalculatorBottomSheet({required this.onResult});

  @override
  _CalculatorBottomSheetState createState() => _CalculatorBottomSheetState();
}

class _CalculatorBottomSheetState extends State<CalculatorBottomSheet> {
  String currentInput = "";
  String displayedValue = "";
  double? firstOperand;
  String? operator;

  final buttonTextStyle = TextStyle(color: Colors.white);
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
              displayedValue,
              style: TextStyle(fontSize: 24, color: Colors.white),
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
      flex: label == "V" ? 2 : 1,
      child: ElevatedButton(
        onPressed: () {
          _handleButtonPress(label);
        },
        child: Text(label, style: buttonTextStyle),
        style: buttonStyle,
      ),
    );
  }

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "=") {
        _calculateResult();
        widget.onResult(displayedValue);
      } else if (value == "AC") {
        _clearCalculator();
      } else if (value == "⌫") {
        _backspace();
      } else {
        currentInput += value;
        displayedValue = currentInput;
      }
    });
  }

  void _clearCalculator() {
    currentInput = "";
    displayedValue = "";
    firstOperand = null;
    operator = null;
  }

  void _backspace() {
    if (currentInput.isNotEmpty) {
      currentInput = currentInput.substring(0, currentInput.length - 1);
      displayedValue = currentInput;
    }
  }

  void _calculateResult() {
    if (currentInput.isNotEmpty) {
      final secondOperand = double.tryParse(currentInput);
      if (secondOperand != null) {
        if (firstOperand != null && operator != null) {
          double result;
          switch (operator) {
            case "+":
              result = firstOperand! + secondOperand;
              break;
            case "-":
              result = firstOperand! - secondOperand;
              break;
            case "×":
              result = firstOperand! * secondOperand;
              break;
            case "÷":
              if (secondOperand != 0) {
                result = firstOperand! / secondOperand;
              } else {
                displayedValue = "Error";
                return;
              }
              break;
            default:
              displayedValue = "Error";
              return;
          }
          firstOperand = result;
          currentInput = result.toString();
          operator = null;
          displayedValue = currentInput;
        } else {
          firstOperand = secondOperand;
        }
      }
    }
  }
}