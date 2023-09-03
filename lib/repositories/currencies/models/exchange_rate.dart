import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExchangeRate extends Equatable {
  final double rate;
  final String iso;
  final int code;
  final int quantity;
  final String date;
  final String name;

  ExchangeRate(
      {required this.rate,
      required this.iso,
      required this.code,
      required this.quantity,
      required this.date,
      required this.name});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      rate: json['rate'],
      iso: json['iso'],
      code: json['code'],
      quantity: json['quantity'],
      date: json['date'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [iso, code, quantity, date, name];
}
