import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.about),
        backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.appTitle,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.aboutContent,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Text(
                '${localizations.about} API', // Utilisation de la traduction existante
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                localizations.aboutContent, // Réutilisation de la même traduction
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  const url = 'https://opentdb.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch URL')), // Message simple en dur
                    );
                  }
                },
                child: Text(
                  'Visit API Website', // Texte en dur ou ajoutez une traduction
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Version 1.0.0', // Version en dur ou ajoutez une traduction
                style: TextStyle(
                  fontSize: 14,
                  color: settings.isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}