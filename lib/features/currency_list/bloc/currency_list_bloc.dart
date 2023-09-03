import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../repositories/currencies/abstract_currency_repository.dart';
import '../../../repositories/currencies/models/exchange_rate.dart';

part 'currency_list_event.dart';

part 'currency_list_state.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  CurrencyListBloc(this.currencyRepository) : super(CurrencyListInitial()) {
    on<LoadCurrencyList>((event, emit) async {
      try {
        if (state is! CurrencyListLoaded) {
          emit(CurrencyListLoading());
        }
        final currencyList = await currencyRepository.getCurrenciesList();
        if (currencyList.isEmpty) {
          emit(CurrencyListLoadingFailure());
        } else {
          emit(CurrencyListLoaded(currencyList: currencyList));
        }
      } catch (e, st) {
        emit(CurrencyListLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractCurrencyRepository currencyRepository;
}
