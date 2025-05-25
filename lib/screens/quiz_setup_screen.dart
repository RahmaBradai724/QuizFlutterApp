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
    {'id': null, 'name': 'Any', 'icon': Icons.category},
    {'id': 9, 'name': 'General Knowledge', 'icon': Icons.public},
    {'id': 10, 'name': 'Entertainment: Books', 'icon': Icons.menu_book},
    {'id': 11, 'name': 'Entertainment: Film', 'icon': Icons.movie},
    {'id': 12, 'name': 'Entertainment: Music', 'icon': Icons.music_note},
    {'id': 13, 'name': 'Entertainment: Musicals & Theatres', 'icon': Icons.theater_comedy},
    {'id': 14, 'name': 'Entertainment: Television', 'icon': Icons.tv},
    {'id': 15, 'name': 'Entertainment: Video Games', 'icon': Icons.sports_esports},
    {'id': 16, 'name': 'Entertainment: Board Games', 'icon': Icons.casino},
    {'id': 17, 'name': 'Science & Nature', 'icon': Icons.nature},
    {'id': 18, 'name': 'Science: Computers', 'icon': Icons.computer},
    {'id': 19, 'name': 'Science: Mathematics', 'icon': Icons.calculate},
    {'id': 20, 'name': 'Mythology', 'icon': Icons.temple_buddhist},
    {'id': 21, 'name': 'Sports', 'icon': Icons.sports_soccer},
    {'id': 22, 'name': 'Geography', 'icon': Icons.map},
    {'id': 23, 'name': 'History', 'icon': Icons.history},
    {'id': 24, 'name': 'Politics', 'icon': Icons.people},
    {'id': 25, 'name': 'Art', 'icon': Icons.palette},
    {'id': 26, 'name': 'Celebrities', 'icon': Icons.star},
    {'id': 27, 'name': 'Animals', 'icon': Icons.pets},
    {'id': 28, 'name': 'Vehicles', 'icon': Icons.directions_car},
    {'id': 29, 'name': 'Entertainment: Comics', 'icon': Icons.book},
    {'id': 30, 'name': 'Science: Gadgets', 'icon': Icons.phone_android},
    {'id': 31, 'name': 'Entertainment: Japanese Anime & Manga', 'icon': Icons.animation},
    {'id': 32, 'name': 'Entertainment: Cartoon & Animations', 'icon': Icons.animation},
  ];

  final List<Map<String, dynamic>> _difficulties = [
    {'value': 'any', 'label': 'Any', 'icon': Icons.all_inclusive, 'color': Colors.purpleAccent},
    {'value': 'easy', 'label': 'Easy', 'icon': Icons.arrow_circle_down, 'color': Colors.green},
    {'value': 'medium', 'label': 'Medium', 'icon': Icons.remove_circle_outline, 'color': Colors.orange},
    {'value': 'hard', 'label': 'Hard', 'icon': Icons.arrow_circle_up, 'color': Colors.red},
  ];

  final List<Map<String, dynamic>> _questionCounts = [
    {'value': 5, 'label': '5 Questions', 'icon': Icons.format_list_numbered},
    {'value': 10, 'label': '10 Questions', 'icon': Icons.format_list_numbered},
    {'value': 15, 'label': '15 Questions', 'icon': Icons.format_list_numbered},
    {'value': 20, 'label': '20 Questions', 'icon': Icons.format_list_numbered},
  ];

  Map<String, dynamic>? _selectedCategory;
  Map<String, dynamic>? _selectedDifficulty;
  Map<String, dynamic>? _selectedQuestionCount;

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
    final isDarkMode = settings.isDarkMode;

    // Theme colors (matched with SettingsScreen)
    final primaryColor = isDarkMode ? Colors.purpleAccent[400]! : Colors.purple[700]!;
    final backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.quizSetup, style: const TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category selection
              _buildSelectionCard(
                title: localizations.selectCategory,
                icon: Icons.category,
                color: primaryColor,
                child: DropdownButton<Map<String, dynamic>>(
                  isExpanded: true,
                  value: _selectedCategory,
                  dropdownColor: cardColor,
                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                  items: _categories.map((category) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: category,
                      child: Row(
                        children: [
                          Icon(category['icon'], color: primaryColor),
                          const SizedBox(width: 10),
                          Text(category['name'], style: TextStyle(color: textColor)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Difficulty selection
              _buildSelectionCard(
                title: localizations.selectDifficulty,
                icon: Icons.speed,
                color: primaryColor,
                child: DropdownButton<Map<String, dynamic>>(
                  isExpanded: true,
                  value: _selectedDifficulty,
                  dropdownColor: cardColor,
                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                  items: _difficulties.map((difficulty) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: difficulty,
                      child: Row(
                        children: [
                          Icon(difficulty['icon'], color: difficulty['color']),
                          const SizedBox(width: 10),
                          Text(
                            _getDifficultyLabel(difficulty['value'], localizations),
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDifficulty = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Question count selection
              _buildSelectionCard(
                title: localizations.selectQuestionCount,
                icon: Icons.format_list_numbered,
                color: primaryColor,
                child: DropdownButton<Map<String, dynamic>>(
                  isExpanded: true,
                  value: _selectedQuestionCount,
                  dropdownColor: cardColor,
                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                  items: _questionCounts.map((count) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: count,
                      child: Row(
                        children: [
                          Icon(count['icon'], color: primaryColor),
                          const SizedBox(width: 10),
                          Text(count['label'], style: TextStyle(color: textColor)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedQuestionCount = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Start button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(
                          categoryId: _selectedCategory!['id'],
                          difficulty: _selectedDifficulty!['value'],
                          questionCount: _selectedQuestionCount!['value'],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow, size: 24, color: Colors.white),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Text(
                      localizations.start,
                      style: const TextStyle(fontSize: 18, color: Colors.white), // Changed text color to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Purple color matching SettingsScreen
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: primaryColor.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    required Color color,
  }) {
    final settings = Provider.of<QuizSettings>(context);
    final isDarkMode = settings.isDarkMode;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;

    return Card(
      elevation: 4,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  String _getDifficultyLabel(String difficulty, AppLocalizations localizations) {
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