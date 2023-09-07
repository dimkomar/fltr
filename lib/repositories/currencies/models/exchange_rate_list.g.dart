// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeRateListAdapter extends TypeAdapter<ExchangeRateList> {
  @override
  final int typeId = 2;

  @override
  ExchangeRateList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExchangeRateList(
      rates: (fields[0] as List).cast<ExchangeRate>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExchangeRateList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.rates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRateListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
