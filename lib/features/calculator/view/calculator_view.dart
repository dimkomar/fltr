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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            currentInput,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _calculatorButton("AC", () {
              currentInput = "";
              setState(() {});
            }),
            _calculatorButton("÷", () {
              currentInput += "/";
              setState(() {});
            }),
            _calculatorButton("×", () {
              currentInput += "*";
              setState(() {});
            }),
            _calculatorButton("⌫", () {
              if (currentInput.isNotEmpty) {
                currentInput = currentInput.substring(0, currentInput.length - 1);
              }
              setState(() {});
            }),
          ],
        ),
        _calculatorRow(["7", "8", "9", "-"]),
        _calculatorRow(["4", "5", "6", "+"]),
        _calculatorRow(["1", "2", "3"]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _calculatorButton("0", () {
              currentInput += "0";
              setState(() {});
            }),
            _calculatorButton(".", () {
              currentInput += ".";
              setState(() {});
            }),
            _calculatorButton("Спрятать", () {
              Navigator.pop(context);
            }),
            _calculatorButton("=", () {
              widget.onResult(currentInput);
              Navigator.pop(context);
            }),
          ],
        ),
      ],
    );
  }

  Widget _calculatorRow(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        return _calculatorButton(value, () {
          currentInput += value;
          setState(() {});
        });
      }).toList(),
    );
  }

  Widget _calculatorButton(String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
    );
  }
}