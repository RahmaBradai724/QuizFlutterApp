import 'package:hive/hive.dart';
import '../models/score.dart';

class ScoreStorage {
  static const String _boxName = 'scoresBox';

  Future<Box<Score>> get _box async {
    return await Hive.openBox<Score>(_boxName);
  }

  Future<void> addScore(Score score) async {
    final box = await _box;
    await box.add(score);
  }

  Future<List<Score>> getScores() async {
    final box = await _box;
    return box.values.toList().reversed.toList(); // Plus récents en premier
  }

  Future<void> clearScores() async {
    final box = await _box;
    await box.clear();
  }

  Future<List<Score>> getScoresByCategoryAndDifficulty(
      String category, String difficulty) async {
    final box = await _box;
    return box.values.where((score) {
      final categoryMatch = category == 'Any' || score.category == category;
      final difficultyMatch = difficulty == 'any' || score.difficulty == difficulty;
      return categoryMatch && difficultyMatch;
    }).toList();
  }
}