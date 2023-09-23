import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/currencies/models/exchange_rate.dart';
import '../../calculator/view/calculator_bottom_sheet.dart';
import '../bloc/currency_list_bloc.dart';
import 'county_flag.dart';

class CurrencyTile extends StatefulWidget {

  const CurrencyTile({
    Key? key,
    required this.currency
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

  void _showCalculatorBottomSheet(BuildContext context, String iso, CurrencyListBloc bloc) {
    //сюда передается исо валюты
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Builder(
          builder: (innerContext) {
            return CalculatorBottomSheet(
              onResult: (result) {
                setState(() {
                  _rateController.text = result;
                });
                bloc.add(UpdateCurrencyValues(newRate: double.parse(result)));
                Navigator.of(context).pop();
              },
            );
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
        _showCalculatorBottomSheet(context, widget.currency.iso, BlocProvider.of<CurrencyListBloc>(context));
        print("Tapped on ${widget.currency.iso}");
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