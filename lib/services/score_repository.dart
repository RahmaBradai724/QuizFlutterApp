import 'package:hive/hive.dart';
import '../models/score.dart';

class ScoreRepository {
  static const String _boxName = 'scoresBox';

  Future<Box<Score>> get _box async => await Hive.openBox<Score>(_boxName);

  Future<void> addScore(Score score) async {
    final box = await _box;
    await box.add(score);
  }

  Future<List<Score>> getAllScores() async {
    final box = await _box;
    return box.values.toList();
  }
  Future<List<Score>> getScoresByCategory(String category) async {
    final box = await Hive.openBox<Score>('scoresBox');
    return box.values.where((score) => score.category == category).toList();
  }

  Future<List<Score>> getScoresByDifficulty(String difficulty) async {
    final box = await Hive.openBox<Score>('scoresBox');
    return box.values.where((score) => score.difficulty == difficulty).toList();
  }

  Future<List<Score>> getScoresByCategoryAndDifficulty(String category, String difficulty) async {
    final box = await Hive.openBox<Score>('scoresBox');
    return box.values
        .where((score) => score.category == category && score.difficulty == difficulty)
        .toList();
  }



  Future<void> clearAllScores() async {
    final box = await _box;
    await box.clear();
  }

  Future<void> deleteScore(Score score) async {
    final box = await _box;
    await score.delete();
  }
  // Dans score_repository.dart
  Future<Map<String, List<Score>>> getScoresGroupedByCategory() async {
    final box = await _box;
    final Map<String, List<Score>> result = {};

    for (final score in box.values) {
      if (!result.containsKey(score.category)) {
        result[score.category] = [];
      }
      result[score.category]!.add(score);
    }

    // Trier chaque liste par score décroissant
    result.forEach((key, scores) {
      scores.sort((a, b) => b.scorePercentage.compareTo(a.scorePercentage));
    });

    return result;
  }
}