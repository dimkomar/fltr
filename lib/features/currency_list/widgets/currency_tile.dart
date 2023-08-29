import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/currencies/models/rate.dart';
import 'county_flag.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({
    Key? key,
    required this.currency,
  }) : super(key: key);

  final Rate currency;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return ListTile(
      //todo get currency mark
        leading: getFlag(currency.iso),


        title: Text(
            currency.name,
            style: theme.bodyMedium
        ),
        subtitle:Text('${currency.rate} \$',
            style: theme.labelMedium
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: (){
          Navigator.of(context).pushNamed(
              '/coin',
              arguments: currency
          );
        }
    );
  }

}