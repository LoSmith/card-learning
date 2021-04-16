// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_card_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LearningCardBoxAdapter extends TypeAdapter<LearningCardBox> {
  @override
  final int typeId = 1;

  @override
  LearningCardBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LearningCardBox(
      fields[0] as String,
      (fields[1] as List)?.cast<FlashCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, LearningCardBox obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningCardBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
