import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'exchange_rate.g.dart';

@HiveType(typeId: 1)
class ExchangeRate extends Equatable {
  @HiveField(0)
  late final double rate;
  @HiveField(1)
  final String iso;
  @HiveField(2)
  final int code;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final String? currencyMark;

  ExchangeRate(
      {required this.rate,
      required this.iso,
      required this.code,
      required this.quantity,
      required this.date,
      required this.name,
      required this.currencyMark});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    String originalName = json['name'];
    String newName = nameReplacement[originalName] ?? originalName;
    String currencyMark = currencySymbols[originalName] ?? '';

    return ExchangeRate(
        rate: json['rate'],
        iso: json['iso'],
        code: json['code'],
        quantity: json['quantity'],
        date: json['date'],
        name: newName,
        currencyMark: currencyMark);
  }

  ExchangeRate copyWith({
    double? rate,
    String? iso,
    int? code,
    int? quantity,
    String? date,
    String? name,
    String? currencyMark,
  }) {
    return ExchangeRate(
      rate: rate ?? this.rate,
      iso: iso ?? this.iso,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      name: name ?? this.name,
      currencyMark: currencyMark ?? this.currencyMark,
    );
  }

  @override
  List<Object?> get props => [iso, code, quantity, date, name, currencyMark];

  static final Map<String, String> nameReplacement = {
    'евро': 'Euro',
    'злотый': 'Polish Zloty',
    'российский рубль': 'Russian Ruble',
    'доллар США': 'US Dollar'
  };

  static final Map<String, String> currencySymbols = {
    'евро': '€',
    'доллар США': '\$',
    'российский рубль': '₽',
    'злотый': 'zł'
  };
}
