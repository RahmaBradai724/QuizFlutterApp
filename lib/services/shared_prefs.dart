import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quizflutter/models/score.dart';

class SharedPrefs {
  final SharedPreferences prefs;

  SharedPrefs(this.prefs);

  Future<void> saveScore(Score score) async {
    final scores = await getScores();
    scores.add(score);
    final jsonList = scores.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList('scores', jsonList);
  }

  Future<List<Score>> getScores() async {
    final jsonList = prefs.getStringList('scores') ?? [];
    return jsonList
        .map((json) => Score.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> clearScores() async {
    await prefs.remove('scores');
  }
}