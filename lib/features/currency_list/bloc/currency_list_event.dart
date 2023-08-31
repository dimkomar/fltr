part of 'currency_list_bloc.dart';

abstract class CurrencyListEvent extends Equatable{}

class LoadCurrencyList extends CurrencyListEvent {
  LoadCurrencyList({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}