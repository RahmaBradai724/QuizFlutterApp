import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizSettings extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _soundsEnabled = true;
  bool _vibrationsEnabled = true;
  bool _notificationsEnabled = true;
  Locale _currentLocale = const Locale('en');

  QuizSettings() {
    _loadSettings();
  }

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get soundsEnabled => _soundsEnabled;
  bool get vibrationsEnabled => _vibrationsEnabled;
  bool get notificationsEnabled => _notificationsEnabled;
  Locale get currentLocale => _currentLocale;

  // Setters and toggle methods
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

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _soundsEnabled = prefs.getBool('soundsEnabled') ?? true;
    _vibrationsEnabled = prefs.getBool('vibrationsEnabled') ?? true;
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    final localeCode = prefs.getString('locale') ?? 'en';
    _currentLocale = Locale(localeCode);
    notifyListeners();
  }

  // Save boolean setting to SharedPreferences
  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Save string setting to SharedPreferences
  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}