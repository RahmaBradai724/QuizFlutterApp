import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/score.dart';
import '../services/score_repository.dart';
class RankingScreen extends StatelessWidget {
  final String? categoryFilter;
  final String? difficultyFilter;

  const RankingScreen({
    super.key,
    this.categoryFilter,
    this.difficultyFilter,
  });

  @override
  Widget build(BuildContext context) {
    final scoreRepository = Provider.of<ScoreRepository>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmClearScores(context, scoreRepository),
          ),
        ],
      ),
      body: FutureBuilder<List<Score>>(
        future: _getFilteredScores(scoreRepository),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No scores recorded',
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          final scores = snapshot.data!..sort((a, b) => b.scorePercentage.compareTo(a.scorePercentage));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getScoreColor(score.scorePercentage),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(score.playerName),
                  subtitle: Text(
                    '${score.category} - ${score.difficulty}\n'
                        '${score.correctAnswers}/${score.totalQuestions} '
                        '(${score.scorePercentage.toStringAsFixed(1)}%)',
                  ),
                  trailing: Text(
                    '${score.date.day}/${score.date.month}/${score.date.year}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAppBarTitle() {
    if (categoryFilter != null && difficultyFilter != null) {
      return Text('$categoryFilter ($difficultyFilter)');
    } else if (categoryFilter != null) {
      return Text(categoryFilter!);
    } else if (difficultyFilter != null) {
      return Text(difficultyFilter!);
    }
    return const Text('All Scores');
  }

  Future<List<Score>> _getFilteredScores(ScoreRepository scoreRepository) {
    if (categoryFilter != null && difficultyFilter != null) {
      return scoreRepository.getScoresByCategoryAndDifficulty(
        categoryFilter!,
        difficultyFilter!,
      );
    } else if (categoryFilter != null) {
      return scoreRepository.getScoresByCategory(categoryFilter!);
    } else if (difficultyFilter != null) {
      return scoreRepository.getScoresByDifficulty(difficultyFilter!);
    }
    return scoreRepository.getAllScores();
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 70) return Colors.green;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  Future<void> _confirmClearScores(BuildContext context, ScoreRepository scoreRepository) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Delete all scores?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await scoreRepository.clearAllScores();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

