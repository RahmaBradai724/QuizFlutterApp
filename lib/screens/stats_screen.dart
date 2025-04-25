import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/utils/localization.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.stats ?? 'Statistics'),
        backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations?.noStats ?? 'No statistics available yet.',
              style: TextStyle(
                fontSize: 16,
                color: settings.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            // Add more statistics widgets as needed
          ],
        ),
      ),
    );
  }
}