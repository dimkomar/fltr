import 'package:flutter_bloc/flutter_bloc.dart';

part 'currency_list_event.dart';
part 'currency_list_state.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  CurrencyListBloc() : super(CurrencyListInitial()) {
    on<CurrencyListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}