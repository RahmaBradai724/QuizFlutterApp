// lib/screens/result_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/question.dart';
import 'package:quizflutter/utils/localization.dart';
import '../models/quiz_settings.dart';
import 'ranking_screen.dart'; // Import the RankingScreen

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Question> questions;
  final List<bool?> answersCorrectness;
  final String category;
  final String difficulty;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.questions,
    required this.answersCorrectness,
    required this.category,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final settings = Provider.of<QuizSettings>(context);
    final isDarkMode = settings.isDarkMode;
    final primaryColor = isDarkMode ? Colors.purpleAccent[400]! : Colors.purple[700]!;

    if (localizations == null) {
      return const Scaffold(
        body: Center(child: Text('Localization not available')),
      );
    }
    //final settings = Provider.of<QuizSettings>(context);
    final percentage = (score / totalQuestions * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.results, style: TextStyle(
            color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Score Card with category and difficulty
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.category, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          category,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.star, size: 18, color: _getDifficultyColor(difficulty)),
                        const SizedBox(width: 8),
                        Text(
                          difficulty.capitalize(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.yourScore,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$score/$totalQuestions ($percentage%)',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: _getScoreColor(score, totalQuestions),
                      ),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: score / totalQuestions,
                      backgroundColor: Colors.grey[300],
                      color: _getScoreColor(score, totalQuestions),
                      minHeight: 20,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // View Details Button
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: Text(localizations.viewDetails),
              onPressed: () => _showDetailedResults(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            // Play Again Button
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.replay),
              label: Text(localizations.playAgain),
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            // View Rankings Button
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.leaderboard),
              label: Text(localizations.viewRankings),
              onPressed: () => _navigateToRankings(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(int score, int total) {
    final percentage = score / total;
    if (percentage >= 0.7) return Colors.green;
    if (percentage >= 0.4) return Colors.orange;
    return Colors.red;
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  void _showDetailedResults(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: theme.cardColor,
        ),
        child: Column(
          children: [
            Text(
              localizations.detailedResults,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: questions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final isCorrect = answersCorrectness[index] ?? false;
                  final userAnswer = _getSelectedAnswer(index);

                  return Card(
                    elevation: 2,
                    color: isCorrect ? Colors.green[50] : Colors.red[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${index + 1}. ${question.question}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${localizations.correctAnswer}: ${question.correctAnswer}',
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          if (!isCorrect) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${localizations.yourAnswer}: $userAnswer',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRankings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RankingScreen(
          categoryFilter: category,
          difficultyFilter: difficulty,
        ),
      ),
    );
  }

  String _getSelectedAnswer(int questionIndex) {
    // Placeholder: Implement logic to retrieve the user's selected answer
    return "Answer ${questionIndex + 1}";
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}