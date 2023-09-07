import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/currencies/models/exchange_rate.dart';
import '../../../repositories/data_providers/rate_provider.dart';
import '../../calculator/view/calculator_bottom_sheet.dart';
import 'county_flag.dart';

class CurrencyTile extends StatefulWidget {

 final ExchangeRateManager manager;


  const CurrencyTile({
    Key? key,
    required this.currency,
    required this.manager,
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

  void _updateRate(String newRate) {
    widget.manager.updateRateByIso(widget.currency.iso, double.parse(newRate));
  }

  void _showCalculatorBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CalculatorBottomSheet(
          onResult: (result) {
            setState(() {
              _rateController.text = result;
            });
            _updateRate(result);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        _showCalculatorBottomSheet(context);
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