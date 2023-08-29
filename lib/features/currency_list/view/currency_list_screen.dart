import 'package:crypto_coins_list/repositories/currencies/abstract_currency_repository.dart';
import 'package:crypto_coins_list/repositories/currencies/currencies_repository.dart';
import 'package:crypto_coins_list/repositories/currencies/models/rate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../widgets/currency_tile.dart';

class CurrencyListScreen extends StatefulWidget {
  const CurrencyListScreen({super.key});

  @override
  State<CurrencyListScreen> createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  List<Rate>? _list;

  @override
  void initState() {
    _loadCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Курсы валют'),
        ),
        body: (_list == null)
            ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: _list!.length,
            separatorBuilder: (context, i) => const Divider(),
            itemBuilder: (context, i) {
              final currency = _list![i];
              return CurrencyTile(currency: currency);
            }
        ),
    );
  }

  Future<void> _loadCurrencies() async {
    //dependencies injections
    _list = await GetIt.I<AbstractCurrencyRepository>().getCurrenciesList();
    setState(() {
    });
  }

}