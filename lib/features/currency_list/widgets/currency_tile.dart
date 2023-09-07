import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/currencies/models/exchange_rate.dart';
import 'county_flag.dart';

class CurrencyTile extends StatefulWidget {
  const CurrencyTile({
    Key? key,
    required this.currency,
  }) : super(key: key);

  final ExchangeRate currency;

  @override
  _CurrencyTileState createState() => _CurrencyTileState();
}

class _CurrencyTileState extends State<CurrencyTile> {
  late TextEditingController _rateController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _rateController = TextEditingController(text: widget.currency.rate.toString());
    _focusNode = FocusNode();
  }

  void _showCalculatorBottomSheet() {
    String currentInput = "";

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                _calculatorRow(["7", "8", "9", "-"], currentInput, setState),
                _calculatorRow(["4", "5", "6", "+"], currentInput, setState),
                _calculatorRow(["1", "2", "3"], currentInput, setState),
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
                      // TODO: add calculation logic here if needed
                      _rateController.text = currentInput;
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _calculatorRow(List<String> values, String currentInput, StateSetter setState) {
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        _showCalculatorBottomSheet();
      },
      child: ListTile(
        leading: getFlag(widget.currency.iso),
        title: Text(widget.currency.name, style: theme.bodyMedium),
        subtitle: Text(widget.currency.iso, style: theme.labelMedium),
        trailing: Text('${_rateController.text} ${widget.currency.currencyMark}', style: theme.bodyMedium),
      ),
    );
  }

  @override
  void dispose() {
    _rateController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}