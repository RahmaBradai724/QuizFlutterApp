import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/utils/localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.settings ?? 'Settings'),
        backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text(localizations?.darkMode ?? 'Dark Mode'),
              value: settings.isDarkMode,
              onChanged: (value) => settings.toggleDarkMode(value),
            ),
            SwitchListTile(
              title: Text(localizations?.enableSounds ?? 'Enable Sounds'),
              value: settings.soundsEnabled,
              onChanged: (value) => settings.setSoundEnabled(value),
            ),
            SwitchListTile(
              title: Text(localizations?.enableVibrations ?? 'Enable Vibrations'),
              value: settings.vibrationsEnabled,
              onChanged: (value) => settings.setVibrationEnabled(value),
            ),
            SwitchListTile(
              title: Text(localizations?.enableNotifications ?? 'Enable Notifications'),
              value: settings.notificationsEnabled,
              onChanged: (value) => settings.setNotificationsEnabled(value),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                localizations?.language ?? 'Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: settings.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            RadioListTile<Locale>(
              title: Text(localizations?.french ?? 'French'),
              value: const Locale('fr'),
              groupValue: settings.currentLocale,
              onChanged: (value) => settings.setLocale(value!),
            ),
            RadioListTile<Locale>(
              title: Text(localizations?.english ?? 'English'),
              value: const Locale('en'),
              groupValue: settings.currentLocale,
              onChanged: (value) => settings.setLocale(value!),
            ),
            RadioListTile<Locale>(
              title: Text(localizations?.arabic ?? 'Arabic'),
              value: const Locale('ar'),
              groupValue: settings.currentLocale,
              onChanged: (value) => settings.setLocale(value!),
            ),
          ],
        ),
      ),
    );
  }
}