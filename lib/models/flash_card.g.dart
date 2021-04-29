// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_card.dart';

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
      fields[4] as String,
      fields[10] as DateTime,
      questionAddition: fields[2] as String,
      questionImage: fields[3] as String,
      solutionAddition: fields[5] as String,
      solutionImage: fields[6] as String,
      timesTested: fields[7] as int,
      timesGotRight: fields[8] as int,
      timesGotWrong: fields[9] as int,
      sortNumber: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FlashCard obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.questionText)
      ..writeByte(2)
      ..write(obj.questionAddition)
      ..writeByte(3)
      ..write(obj.questionImage)
      ..writeByte(4)
      ..write(obj.solutionText)
      ..writeByte(5)
      ..write(obj.solutionAddition)
      ..writeByte(6)
      ..write(obj.solutionImage)
      ..writeByte(7)
      ..write(obj.timesTested)
      ..writeByte(8)
      ..write(obj.timesGotRight)
      ..writeByte(9)
      ..write(obj.timesGotWrong)
      ..writeByte(10)
      ..write(obj.lastTimeTested)
      ..writeByte(11)
      ..write(obj.sortNumber);
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
