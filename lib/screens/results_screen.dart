import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/models/question.dart';
import 'package:quizflutter/screens/home_screen.dart';
import 'package:quizflutter/screens/quiz_setup_screen.dart';
import 'package:quizflutter/utils/localization.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Question> questions;
  final List<bool?> answersCorrectness;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.questions,
    required this.answersCorrectness,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.results),
        backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${localizations.yourScore}: $score/$totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final isCorrect = answersCorrectness[index];
                  return Card(
                    color: isCorrect == true
                        ? Colors.green[100]
                        : isCorrect == false
                        ? Colors.red[100]
                        : Colors.grey[100],
                    child: ListTile(
                      title: Text(question.question),
                      subtitle: Text(
                        '${localizations.correctAnswer}: ${question.correctAnswer}',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const QuizSetupScreen()),
              ),
              child: Text(localizations.playAgain),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              ),
              child: Text(localizations.backToHome),
            ),
          ],
        ),
      ),
    );
  }
}