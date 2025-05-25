import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/utils/localization.dart';
import 'package:quizflutter/models/score.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.scoresHistory),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await settings.clearScores();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.scoresCleared)),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Score>>(
        future: settings.getScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                localizations.noScoresYet,
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          final scores = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              return _buildScoreCard(score, localizations);
            },
          );
        },
      ),
    );
  }

  Widget _buildScoreCard(Score score, AppLocalizations localizations) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  score.category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  backgroundColor: _getDifficultyColor(score.difficulty),
                  label: Text(
                    _getDifficultyText(score.difficulty, localizations),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('${localizations.playerName}: ${score.playerName}'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: score.scorePercentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getScoreColor(score.scorePercentage),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${score.correctAnswers}/${score.totalQuestions} (${score.scorePercentage.toStringAsFixed(1)}%)',
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 4),
            Text(
              '${localizations.date}: ${_formatDate(score.date)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'easy': return Colors.green;
      case 'medium': return Colors.orange;
      case 'hard': return Colors.red;
      default: return Colors.blue;
    }
  }

  String _getDifficultyText(String difficulty, AppLocalizations localizations) {
    switch (difficulty) {
      case 'easy': return localizations.easy;
      case 'medium': return localizations.medium;
      case 'hard': return localizations.hard;
      default: return localizations.any;
    }
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 70) return Colors.green;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}