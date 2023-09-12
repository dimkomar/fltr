
import '../currencies/currencies_repository.dart';
import '../currencies/models/exchange_rate.dart';

class ExchangeRateManager {
  final CurrencyRepository _currencyRepository;
  List<ExchangeRate> _currentRates = [];

  ExchangeRateManager(this._currencyRepository);

  // Загрузка курсов валют
  Future<void> loadExchangeRates() async {
    _currentRates = await _currencyRepository.getCurrenciesList();
  }

  // Получение текущего курса для определённой валюты
  ExchangeRate? getExchangeRate(String iso) {
    try {
      return _currentRates.firstWhere((rate) => rate.iso == iso);
    } catch (e) {
      return null;
    }
  }

  // Пересчёт значения на основе курса валюты
  double recalculateValue(String iso, double baseValue) {
    final rate = getExchangeRate(iso);
    return baseValue * rate.rate;
  }
}
