import 'package:hive/hive.dart';
import '../models/score.dart';

class ScoreStorage {
  static const String _boxName = 'scores';

  Future<Box<Score>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<Score>(_boxName);
    }
    return Hive.box<Score>(_boxName);
  }

  Future<void> addScore(Score score) async {
    final box = await _box;
    await box.add(score);
  }

  Future<List<Score>> getScores() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<List<Score>> getScoresByCategoryAndDifficulty(
      String category, String difficulty) async {
    final allScores = await getScores();
    return allScores
        .where((s) => s.category == category && s.difficulty == difficulty)
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));
  }

  Future<void> clearScores() async {
    final box = await _box;
    await box.clear();
  }
}