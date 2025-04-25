import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/screens/quiz_screen.dart';
import 'package:quizflutter/utils/localization.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  _QuizSetupScreenState createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'id': null, 'name': 'Any'},
    {'id': 9, 'name': 'General Knowledge'},
    {'id': 10, 'name': 'Entertainment: Books'},
    {'id': 11, 'name': 'Entertainment: Film'},
    {'id': 12, 'name': 'Entertainment: Music'},
    {'id': 13, 'name': 'Entertainment: Musicals & Theatres'},
    {'id': 14, 'name': 'Entertainment: Television'},
    {'id': 15, 'name': 'Entertainment: Video Games'},
    {'id': 16, 'name': 'Entertainment: Board Games'},
    {'id': 17, 'name': 'Science & Nature'},
    {'id': 18, 'name': 'Science: Computers'},
    {'id': 19, 'name': 'Science: Mathematics'},
    {'id': 20, 'name': 'Mythology'},
    {'id': 21, 'name': 'Sports'},
    {'id': 22, 'name': 'Geography'},
    {'id': 23, 'name': 'History'},
    {'id': 24, 'name': 'Politics'},
    {'id': 25, 'name': 'Art'},
    {'id': 26, 'name': 'Celebrities'},
    {'id': 27, 'name': 'Animals'},
    {'id': 28, 'name': 'Vehicles'},
    {'id': 29, 'name': 'Entertainment: Comics'},
    {'id': 30, 'name': 'Science: Gadgets'},
    {'id': 31, 'name': 'Entertainment: Japanese Anime & Manga'},
    {'id': 32, 'name': 'Entertainment: Cartoon & Animations'},
  ];

  final List<String> _difficulties = ['any', 'easy', 'medium', 'hard'];
  final List<int> _questionCounts = [5, 10, 15, 20];

  Map<String, dynamic>? _selectedCategory;
  String? _selectedDifficulty;
  int? _selectedQuestionCount;

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[0];
    _selectedDifficulty = _difficulties[0];
    _selectedQuestionCount = _questionCounts[0];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.quiz),
        backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.selectCategory,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<Map<String, dynamic>>(
              isExpanded: true,
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: category,
                  child: Text(category['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              localizations.selectDifficulty,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedDifficulty,
              items: _difficulties.map((difficulty) {
                return DropdownMenuItem<String>(
                  value: difficulty,
                  child: Text(localizationsKey(difficulty, localizations)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDifficulty = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              localizations.selectQuestionCount,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<int>(
              isExpanded: true,
              value: _selectedQuestionCount,
              items: _questionCounts.map((count) {
                return DropdownMenuItem<int>(
                  value: count,
                  child: Text('$count'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedQuestionCount = value;
                });
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(
                        categoryId: _selectedCategory!['id'],
                        difficulty: _selectedDifficulty!,
                        questionCount: _selectedQuestionCount!,
                      ),
                    ),
                  );
                },
                child: Text(localizations.start),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String localizationsKey(String difficulty, AppLocalizations localizations) {
    switch (difficulty) {
      case 'easy':
        return localizations.easy;
      case 'medium':
        return localizations.medium;
      case 'hard':
        return localizations.hard;
      case 'any':
      default:
        return localizations.any;
    }
  }
}