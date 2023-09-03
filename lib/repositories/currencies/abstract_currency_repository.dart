import 'models/exchange_rate.dart';

abstract class AbstractCurrencyRepository {
  Future<List<ExchangeRate>> getCurrenciesList();
}
