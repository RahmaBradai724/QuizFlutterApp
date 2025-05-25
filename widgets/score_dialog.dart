import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/score.dart';
import 'package:quizflutter/services/score_repository.dart';


class ScoreDialog extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final String category;
  final String difficulty;

  const ScoreDialog({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.category,
    required this.difficulty,
  });

  @override
  State<ScoreDialog> createState() => _ScoreDialogState();
}

class _ScoreDialogState extends State<ScoreDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scoreRepository = Provider.of<ScoreRepository>(context);

    return AlertDialog(
      title: const Text('Enregistrer votre score'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Score: ${widget.correctAnswers}/${widget.totalQuestions}'),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Votre nom',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () async {
            final score = Score(
              playerName: _nameController.text,
              category: widget.category,
              difficulty: widget.difficulty,
              correctAnswers: widget.correctAnswers,
              totalQuestions: widget.totalQuestions,
              date: DateTime.now(),
            );

            await scoreRepository.addScore(score);
            Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}