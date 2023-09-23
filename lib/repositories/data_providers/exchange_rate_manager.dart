
import '../currencies/currencies_repository.dart';
import '../currencies/models/exchange_rate.dart';

class ExchangeRateManager {
  List<ExchangeRate> _currentRates = [];

  ExchangeRateManager();

  ExchangeRate? getExchangeRate(String iso) {
    try {
      return _currentRates.firstWhere((rate) => rate.iso == iso);
    } catch (e) {
      return null;
    }
  }

  double recalculateValue(String iso, double baseValue) {
    final rate = getExchangeRate(iso);
    return baseValue * rate!.rate;
  }
}
