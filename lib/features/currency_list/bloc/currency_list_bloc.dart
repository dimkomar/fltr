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
      if (_isLoading) return;
      try {
        _isLoading = true;
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
        _isLoading = false;
        event.completer?.complete();
      }
    });

    on<UpdateCurrencyValues>((event, emit) async {
      if (state is CurrencyListLoaded) {
        final currentState = state as CurrencyListLoaded;
        final updatedCurrencyList = _calculateNewCurrencyValues(currentState.currencyList, event.newRate);
        emit(CurrencyListLoaded(currencyList: updatedCurrencyList));
      }
    });
  }

  List<ExchangeRate> _calculateNewCurrencyValues(List<ExchangeRate> currentRates, double newBaseValue) {
    // В этом методе вы должны пересчитать курсы валют на основе newBaseValue
    // Здесь приведен простой пример, вы должны адаптировать его в зависимости от ваших требований:
    return currentRates.map((rate) {
      double newRate = rate.rate * newBaseValue; // Это просто пример формулы!
      return rate.copyWith(rate: newRate); // Предполагается, что у вас есть метод copyWith в ExchangeRate
    }).toList();
  }

  final AbstractCurrencyRepository currencyRepository;
  bool _isLoading = false;
}
