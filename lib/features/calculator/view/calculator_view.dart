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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((value) {
          if (value == "=" || value == "V") {
            return Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _handleButtonPress(value);
                },
                child: Text(value, style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  padding: EdgeInsets.zero,
                  primary: Colors.black,
                ),
              ),
            );
          } else {
            return _calculatorButton(value, () {
              _handleButtonPress(value);
            });
          }
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
          padding: EdgeInsets.zero,
          primary: Colors.black,
        ),
      ),
    );
  }

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "=") {
        _calculateResult();
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
    if (currentInput.isNotEmpty && operator != null) {
      final secondOperand = double.tryParse(currentInput);
      if (secondOperand != null) {
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
        displayedValue = result.toString();
        currentInput = result.toString();
        firstOperand = null;
        operator = null;
      }
    }
  }
}