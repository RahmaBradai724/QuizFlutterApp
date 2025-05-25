import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/score.dart';
import 'package:quizflutter/services/score_repository.dart';
import 'package:quizflutter/screens/ranking_screen.dart';
import 'package:quizflutter/utils/localization.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreRepo = Provider.of<ScoreRepository>(context);
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.scoreCategories),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: localizations.filterByDifficulty,
            onPressed: () => _showDifficultyFilter(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, List<Score>>>(
        future: scoreRepo.getScoresGroupedByCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                localizations.noScoresRecorded,
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          final categories = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 8),
              ...categories.entries.map((entry) => _buildCategoryCard(context, entry)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, MapEntry<String, List<Score>> entry) {
    final theme = Theme.of(context);
    final bestScore = entry.value.first;
    final difficulties = _getUniqueDifficulties(entry.value);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToCategoryScores(context, entry.key),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    label: Text('${entry.value.length}'),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.of(context)!.bestScore}: ${bestScore.playerName} - ${bestScore.scorePercentage.toStringAsFixed(1)}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 12),
              if (difficulties.isNotEmpty) ...[
                Text(
                  '${AppLocalizations.of(context)!.difficulties}:',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: difficulties.map((diff) =>
                      _buildDifficultyChip(context, entry.key, diff)
                  ).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(BuildContext context, String category, String difficulty) {
    final color = _getDifficultyColor(difficulty);

    return ActionChip(
      label: Text(
        difficulty,
        style: TextStyle(
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: color,
      onPressed: () => _navigateToFilteredScores(
        context,
        category: category,
        difficulty: difficulty,
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy': return Colors.green;
      case 'medium': return Colors.orange;
      case 'hard': return Colors.red;
      default: return Colors.blueGrey;
    }
  }

  Set<String> _getUniqueDifficulties(List<Score> scores) {
    return scores.map((s) => s.difficulty).toSet();
  }

  void _navigateToCategoryScores(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RankingScreen(
          categoryFilter: category,
          difficultyFilter: '',
        ),
      ),
    );
  }

  void _navigateToFilteredScores(
      BuildContext context, {
        required String category,
        required String difficulty,
      }) {
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

  void _showDifficultyFilter(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.filterByDifficulty,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: Text(localizations.allDifficulties),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.star, color: Colors.green.shade400),
              title: Text(localizations.easy),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RankingScreen(
                      difficultyFilter: 'easy',
                      categoryFilter: '',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.orange.shade400),
              title: Text(localizations.medium),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RankingScreen(
                      difficultyFilter: 'medium',
                      categoryFilter: '',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.red.shade400),
              title: Text(localizations.hard),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RankingScreen(
                      difficultyFilter: 'hard',
                      categoryFilter: '',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}