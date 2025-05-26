// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **
// TypeAdapterGenerator
// **

class ScoreAdapter extends TypeAdapter<Score> {
  @override
  final int typeId = 0;

  @override
  Score read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Score(
      playerName: fields[0] as String,
      category: fields[1] as String,
      difficulty: fields[2] as String,
      correctAnswers: fields[3] as int,
      totalQuestions: fields[4] as int,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Score obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.playerName)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.difficulty)
      ..writeByte(3)
      ..write(obj.correctAnswers)
      ..writeByte(4)
      ..write(obj.totalQuestions)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.scorePercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ScoreAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}