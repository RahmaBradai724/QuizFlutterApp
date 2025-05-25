import 'package:hive/hive.dart';

part 'score.g.dart';

@HiveType(typeId: 0)
class Score extends HiveObject {
  @HiveField(0)
  final String playerName;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String difficulty;

  @HiveField(3)
  final int correctAnswers;

  @HiveField(4)
  final int totalQuestions;

  @HiveField(5)
  final DateTime date;

  @HiveField(6, defaultValue: 0.0)
  final double scorePercentage;

  Score({
    required this.playerName,
    required this.category,
    required this.difficulty,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.date,
  }) : scorePercentage = (correctAnswers / totalQuestions * 100);

  int get score => correctAnswers;

  @override
  String toString() {
    return '$playerName: $correctAnswers/$totalQuestions ($scorePercentage%) - $difficulty $category';
  }
}