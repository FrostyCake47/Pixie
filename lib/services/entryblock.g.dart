// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entryblock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryBlockDetailsAdapter extends TypeAdapter<EntryBlockDetails> {
  @override
  final int typeId = 1;

  @override
  EntryBlockDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntryBlockDetails(
      id: fields[0] as int,
      title: fields[1] as String,
      subtitle: fields[2] as String,
    )
      ..date = fields[3] as String
      ..time = fields[4] as String
      ..day = fields[5] as String
      ..content = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, EntryBlockDetails obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.day)
      ..writeByte(6)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryBlockDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
