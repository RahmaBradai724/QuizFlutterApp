import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/screens/quiz_setup_screen.dart';
import 'package:quizflutter/screens/settings_screen.dart';
import 'package:quizflutter/screens/about_screen.dart';
import 'package:quizflutter/utils/localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizSetupScreen()),
              ),
              child: Text(localizations.startQuiz),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
              child: Text(localizations.settings),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              ),
              child: Text(localizations.about),
            ),
          ],
        ),
      ),
    );
  }
}