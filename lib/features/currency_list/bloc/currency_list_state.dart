part of 'currency_list_bloc.dart';

abstract class CurrencyListState extends Equatable {}

class CurrencyListInitial extends CurrencyListState {
  @override
  List<Object?> get props => [];
}

class CurrencyListLoading extends CurrencyListState {
  @override
  List<Object?> get props => [];
}

class CurrencyListLoaded extends CurrencyListState {
  CurrencyListLoaded({
    required this.currencyList,
  });

  final List<Rate> currencyList;

  @override
  List<Object?> get props => [currencyList];
}

class CurrencyListLoadingFailure extends CurrencyListState {
  CurrencyListLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
