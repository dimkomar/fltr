import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/currencies/models/exchange_rate.dart';
import 'county_flag.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({
    Key? key,
    required this.currency,
  }) : super(key: key);

  final ExchangeRate currency;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return ListTile(
        leading: getFlag(currency.iso),
        title: Text(currency.name, style: theme.bodyMedium),
        subtitle: Text(currency.iso, style: theme.labelMedium),
        trailing: Text('${currency.rate} ${currency.currencyMark}', style: theme.bodyMedium)
    );
  }
}
