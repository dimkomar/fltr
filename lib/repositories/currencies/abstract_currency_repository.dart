import 'models/rate.dart';

abstract class AbstractCurrencyRepository {
  Future<List<Rate>> getCurrenciesList();
}
