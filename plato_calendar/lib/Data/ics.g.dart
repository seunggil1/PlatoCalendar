// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarDataAdapter extends TypeAdapter<CalendarData> {
  @override
  final int typeId = 1;

  @override
  CalendarData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as DateTime,
      fields[5] as bool,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
      fields[10] as bool,
      fields[11] as bool,
      fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarData obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.summary)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.start)
      ..writeByte(4)
      ..write(obj.end)
      ..writeByte(5)
      ..write(obj.isPeriod)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.semester)
      ..writeByte(8)
      ..write(obj.classCode)
      ..writeByte(9)
      ..write(obj.className)
      ..writeByte(10)
      ..write(obj.disable)
      ..writeByte(11)
      ..write(obj.finished)
      ..writeByte(12)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
