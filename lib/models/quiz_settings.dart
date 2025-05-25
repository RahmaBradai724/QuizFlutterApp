import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/score_storage.dart';
import '../models/score.dart';

class QuizSettings extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _soundsEnabled = true;
  bool _vibrationsEnabled = true;
  bool _notificationsEnabled = true;
  Locale _currentLocale = const Locale('en');
  final ScoreStorage _scoreStorage = ScoreStorage();
  String _playerName = '';

  QuizSettings() {
    _loadSettings();
  }

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get soundsEnabled => _soundsEnabled;
  bool get vibrationsEnabled => _vibrationsEnabled;
  bool get notificationsEnabled => _notificationsEnabled;
  Locale get currentLocale => _currentLocale;
  String get playerName => _playerName;

  Future<void> saveScore({
    required String playerName,
    required String category,
    required String difficulty,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final newScore = Score(
      playerName: playerName,
      category: category,
      difficulty: difficulty,
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
      date: DateTime.now(),
    );

    await _scoreStorage.addScore(newScore);
    notifyListeners();
  }

  Future<List<Score>> getScores() async {
    return await _scoreStorage.getScores();
  }

  Future<void> clearScores() async {
    await _scoreStorage.clearScores();
    notifyListeners();
  }

  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
    _saveString('playerName', name);
  }

  void toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await _saveBool('isDarkMode', value);
    notifyListeners();
  }

  void setSoundEnabled(bool value) async {
    _soundsEnabled = value;
    await _saveBool('soundsEnabled', value);
    notifyListeners();
  }

  void setVibrationEnabled(bool value) async {
    _vibrationsEnabled = value;
    await _saveBool('vibrationsEnabled', value);
    notifyListeners();
  }

  void setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;
    await _saveBool('notificationsEnabled', value);
    notifyListeners();
  }

  void setLocale(Locale locale) async {
    if (['en', 'fr', 'ar'].contains(locale.languageCode)) {
      _currentLocale = locale;
      await _saveString('locale', locale.languageCode);
      notifyListeners();
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _soundsEnabled = prefs.getBool('soundsEnabled') ?? true;
    _vibrationsEnabled = prefs.getBool('vibrationsEnabled') ?? true;
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    final localeCode = prefs.getString('locale') ?? 'en';
    _currentLocale = Locale(localeCode);
    _playerName = prefs.getString('playerName') ?? '';
    notifyListeners();
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}