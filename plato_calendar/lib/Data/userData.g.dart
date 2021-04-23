// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarTypeAdapter extends TypeAdapter<CalendarType> {
  @override
  final int typeId = 2;

  @override
  CalendarType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CalendarType.split;
      case 1:
        return CalendarType.integrated;
      default:
        return CalendarType.split;
    }
  }

  @override
  void write(BinaryWriter writer, CalendarType obj) {
    switch (obj) {
      case CalendarType.split:
        writer.writeByte(0);
        break;
      case CalendarType.integrated:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
