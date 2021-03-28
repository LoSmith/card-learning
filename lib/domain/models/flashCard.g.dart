// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashCard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashCardAdapter extends TypeAdapter<FlashCard> {
  @override
  final int typeId = 0;

  @override
  FlashCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashCard(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FlashCard obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.solution);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
