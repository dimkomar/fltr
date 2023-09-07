
import '../currencies/models/exchange_rate.dart';

class ExchangeRateManager {
  List<ExchangeRate> rates = [];

  void addRate(ExchangeRate rate) {
    rates.add(rate);
  }

  void removeRateByIso(String iso) {
    rates.removeWhere((rate) => rate.iso == iso);
  }

  void updateRateByIso(String iso, double newRate) {
    for (var rate in rates) {
      if (rate.iso == iso) {
        rate = ExchangeRate(
          rate: newRate,
          iso: rate.iso,
          code: rate.code,
          quantity: rate.quantity,
          date: rate.date,
          name: rate.name,
          currencyMark: rate.currencyMark,
        );
      }
    }
  }

  void updateRates(List<ExchangeRate> rates, String isoToUpdate, double newRate) {
    // Find the old rate of the currency whose rate we want to update
    var oldRateOfUpdatedCurrency = rates.firstWhere((rate) => rate.iso == isoToUpdate).rate;

    // Calculate the change factor
    var changeFactor = newRate / oldRateOfUpdatedCurrency;

    // Update all rates based on the change factor
    for (var rate in rates) {
      rate.rate = rate.rate * changeFactor;  // Note: Make sure the rate property is mutable.
    }
  }

  // Тут ваш код для пересчета курсов между валютами
  void recalculateRates(String baseIso) {
    final baseRate = rates.firstWhere((rate) => rate.iso == baseIso);

    for (var rate in rates) {
      if (rate.iso != baseIso) {
        // Пример: вы можете пересчитать курсы на основе нового курса для базовой валюты
        double recalculatedRate = rate.rate / baseRate.rate;
        rate = ExchangeRate(
          rate: recalculatedRate,
          iso: rate.iso,
          code: rate.code,
          quantity: rate.quantity,
          date: rate.date,
          name: rate.name,
          currencyMark: rate.currencyMark,
        );
      }
    }
  }
}
