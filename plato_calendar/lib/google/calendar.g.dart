// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoogleCalendarTokenAdapter extends TypeAdapter<GoogleCalendarToken> {
  @override
  final int typeId = 3;

  @override
  GoogleCalendarToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoogleCalendarToken(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as String,
      (fields[4] as List)!.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GoogleCalendarToken obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.expiry)
      ..writeByte(3)
      ..write(obj.refreshToken)
      ..writeByte(4)
      ..write(obj.scopes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoogleCalendarTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
