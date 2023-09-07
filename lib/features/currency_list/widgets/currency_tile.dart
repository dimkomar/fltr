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

  void _showBottomSheet(BuildContext context) {
    String currentInput = "";

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentInput,
              style: TextStyle(fontSize: 24),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 12, // 10 numbers + . + =
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              if (index < 9) {
                return ElevatedButton(
                  onPressed: () {
                    currentInput += (index + 1).toString();
                    setState(() {});
                  },
                  child: Text((index + 1).toString()),
                );
              } else if (index == 9) {
                return ElevatedButton(
                  onPressed: () {
                    currentInput += ".";
                    setState(() {});
                  },
                  child: Text("."),
                );
              } else if (index == 10) {
                return ElevatedButton(
                  onPressed: () {
                    currentInput += "0";
                    setState(() {});
                  },
                  child: Text("0"),
                );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    _rateController.text = currentInput;
                    Navigator.pop(context);
                  },
                  child: Text("="),
                );
              }
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Спрятать"),
          ),
        ],
      ),
    ).then((value) {
      _focusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        _showBottomSheet(context);
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