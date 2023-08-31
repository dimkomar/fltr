import 'dart:async';

import 'package:crypto_coins_list/features/currency_list/bloc/currency_list_bloc.dart';
import 'package:crypto_coins_list/repositories/currencies/abstract_currency_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/currency_tile.dart';

class CurrencyListScreen extends StatefulWidget {
  const CurrencyListScreen({super.key});

  @override
  State<CurrencyListScreen> createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  final _currencyListBloc =
      CurrencyListBloc(GetIt.I<AbstractCurrencyRepository>());

  @override
  void initState() {
    _currencyListBloc.add(LoadCurrencyList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Курсы валют'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _currencyListBloc.add(LoadCurrencyList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
            bloc: _currencyListBloc,
            builder: (context, state) {
              if (state is CurrencyListLoaded) {
                return ListView.separated(
                  itemCount: state.currencyList.length,
                  separatorBuilder: (context, i) => const Divider(),
                  itemBuilder: (context, i) {
                    final currency = state.currencyList[i];
                    return CurrencyTile(currency: currency);
                  },
                );
              }
              if (state is CurrencyListLoadingFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Something went wrond',
                          style: theme.textTheme.headlineMedium),
                      Text('Please try again later',
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 16)),
                      SizedBox(height: 30),
                      TextButton(onPressed: () {
                        _currencyListBloc.add(LoadCurrencyList());
                      }, child: Text('Try again'))
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
