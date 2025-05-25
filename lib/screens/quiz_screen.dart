import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/models/question.dart';
import 'package:quizflutter/screens/ResultScreen.dart';
import 'package:quizflutter/utils/localization.dart';

class QuizScreen extends StatefulWidget {
  final int? categoryId;
  final String difficulty;
  final int questionCount;

  const QuizScreen({
    super.key,
    this.categoryId,
    required this.difficulty,
    required this.questionCount,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _remainingTime = 20;
  Timer? _timer;
  String? _selectedAnswer;
  bool _isAnswerCorrect = false;
  bool _isLoading = true;
  List<Question> _questions = [];
  List<bool?> _answersCorrectness = [];
  late AudioPlayer _audioPlayer;
  late AnimationController _animationController;
  late Animation<double> _timerAnimation;

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

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _timerAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _fetchQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchQuestions() async {
    try {
      String url = 'https://opentdb.com/api.php?amount=${widget.questionCount}&type=multiple';
      if (widget.categoryId != null) {
        url += '&category=${widget.categoryId}';
      }
      if (widget.difficulty != 'any') {
        url += '&difficulty=${widget.difficulty}';
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final unescape = HtmlUnescape();
        setState(() {
          _questions = data['results'].map<Question>((question) {
            final incorrectAnswers = List<String>.from(question['incorrect_answers']);
            final allAnswers = [...incorrectAnswers, question['correct_answer']]..shuffle();
            return Question(
              question: unescape.convert(question['question']),
              options: allAnswers.map((answer) => unescape.convert(answer)).toList(),
              correctAnswer: unescape.convert(question['correct_answer']),
            );
          }).toList();
          _answersCorrectness = List<bool?>.filled(_questions.length, null);
          _isLoading = false;
          _startTimer();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.noQuestionsAvailable)),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _startTimer() {
    _remainingTime = 20;
    _timer?.cancel();
    _animationController.reset();
    _animationController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _animationController.stop();
          _handleTimeUp();
        }
      });
    });
  }

  void _handleTimeUp() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _nextQuestion();
    } else {
      _endQuiz();
    }
  }

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _isAnswerCorrect = answer == _questions[_currentQuestionIndex].correctAnswer;
      _answersCorrectness[_currentQuestionIndex] = _isAnswerCorrect;
      _timer?.cancel();
      _animationController.stop();

      if (_isAnswerCorrect) {
        _audioPlayer.play(AssetSource('sounds/correct.mp3'));
      } else {
        _audioPlayer.play(AssetSource('sounds/wrong.mp3'));
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _isAnswerCorrect = false;
      _startTimer();
    });
  }

  void _endQuiz() async {
    final score = _answersCorrectness.where((answer) => answer == true).length;
    final settings = Provider.of<QuizSettings>(context, listen: false);

    await settings.saveScore(
      playerName: settings.playerName,
      category: widget.categoryId?.toString() ?? 'Any',
      difficulty: widget.difficulty,
      correctAnswers: score,
      totalQuestions: _questions.length,
    );

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: score,
          totalQuestions: _questions.length,
          questions: _questions,
          answersCorrectness: _answersCorrectness,
          category: widget.categoryId?.toString() ?? 'Any',
          difficulty: widget.difficulty,
        ),
      ),
    );
  }

  String _selectedCategoryName() {
    if (widget.categoryId == null) return 'Any';
    final category = _categories.firstWhere(
          (c) => c['id'] == widget.categoryId,
      orElse: () => {'name': 'Unknown'},
    );
    return category['name'];
  }

  String _selectedDifficultyName(AppLocalizations localizations) {
    switch (widget.difficulty) {
      case 'easy':
        return localizations.easy;
      case 'medium':
        return localizations.medium;
      case 'hard':
        return localizations.hard;
      default:
        return localizations.any;
    }
  }

  String _getLoadingSubtitle(AppLocalizations localizations) {
    return '${localizations.category}: ${_selectedCategoryName()}\n'
        '${localizations.difficulty}: ${_selectedDifficultyName(localizations)}';
  }

  AppBar _buildAppBar(AppLocalizations localizations, Color primaryDarkColor) {
    return AppBar(
      title: Text(
        localizations.quiz,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      backgroundColor: primaryDarkColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline_rounded, size: 30),
          onPressed: _showQuizInfoDialog,
        ),
      ],
    );
  }

  Widget _buildQuizHeader(AppLocalizations localizations, Color primaryColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(0.2), primaryColor.withOpacity(0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(_categories.firstWhere(
                        (c) => c['id'] == widget.categoryId,
                    orElse: () => {'icon': Icons.category},
                  )['icon'], color: primaryColor, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    _selectedCategoryName(),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                '${((_currentQuestionIndex + 1) / _questions.length * 100).round()}%',
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${localizations.difficulty}: ${_selectedDifficultyName(localizations)}',
            style: TextStyle(
              color: textColor.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question, Color cardColor, Color primaryColor, Color textColor,  AppLocalizations localizations) {
    return Card(
      color: cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      shadowColor: primaryColor.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor.withOpacity(0.3), primaryColor.withOpacity(0.5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.question_mark_rounded, color: cardColor, size: 26),
                ),
                const SizedBox(width: 12),
                Text(
                  '${localizations.question} ${_currentQuestionIndex + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              question.question,
              style: TextStyle(
                fontSize: 24,
                color: textColor,
                fontWeight: FontWeight.w600,
                height: 1.4,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption({
    required String option,
    required Question currentQuestion,
    required bool isDarkMode,
    required Color correctColor,
    required Color wrongColor,
    required Color textColor,
    required Color cardColor,
    required Color primaryColor,
  }) {
    final isSelected = _selectedAnswer == option;
    final isCorrect = option == currentQuestion.correctAnswer;
    final showCorrectAnswer = _selectedAnswer != null && !_isAnswerCorrect && isCorrect;

    Color backgroundColor = cardColor;
    Color borderColor = primaryColor.withOpacity(0.3);
    Color optionTextColor = textColor;
    IconData iconData = Icons.circle_outlined;
    Color iconColor = primaryColor;

    if (isSelected) {
      backgroundColor = _isAnswerCorrect ? correctColor : wrongColor;
      borderColor = Colors.transparent;
      optionTextColor = Colors.white;
      iconData = _isAnswerCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded;
      iconColor = Colors.white;
    } else if (showCorrectAnswer) {
      backgroundColor = correctColor.withOpacity(0.3);
      borderColor = correctColor;
      iconData = Icons.check_circle_outline_rounded;
      iconColor = correctColor;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: [
            if (isSelected || showCorrectAnswer)
              BoxShadow(
                color: (isSelected ? (_isAnswerCorrect ? correctColor : wrongColor) : correctColor)
                    .withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _selectedAnswer == null ? () => _selectAnswer(option) : null,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: Icon(
                      iconData,
                      key: ValueKey(iconData),
                      color: iconColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 20,
                        color: optionTextColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimer(Color primaryColor) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(
            value: _timerAnimation.value,
            strokeWidth: 6,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              _remainingTime > 10 ? Colors.green : Colors.red,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_rounded,
              color: primaryColor,
              size: 20,
            ),
            Text(
              '$_remainingTime s',
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showQuizInfoDialog() {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context, listen: false);
    final isDarkMode = settings.isDarkMode;
    final primaryColor = isDarkMode ? Colors.purpleAccent[400]! : Colors.purple[700]!;
    final cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.quiz_rounded, color: primaryColor, size: 34),
                  const SizedBox(width: 12),
                  Text(
                    localizations.quizInfo,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildInfoRow(Icons.category_rounded,
                  '${localizations.category}:', _selectedCategoryName()),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.speed_rounded,
                  '${localizations.difficulty}:', _selectedDifficultyName(localizations)),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.format_list_numbered_rounded,
                  '${localizations.numberOfQuestions}:', '${_questions.length}'),
              const SizedBox(height: 28),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  child: Text(
                    localizations.ok,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    final settings = Provider.of<QuizSettings>(context, listen: false);
    final isDarkMode = settings.isDarkMode;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[600]!;

    return Row(
      children: [
        Icon(icon, color: secondaryTextColor, size: 26),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);
    final isDarkMode = settings.isDarkMode;

    // Enhanced theme colors with better contrast
    final primaryColor = isDarkMode ? Colors.purpleAccent[400]! : Colors.purple[700]!;
    final primaryDarkColor = isDarkMode ? Colors.purpleAccent[700]! : Colors.purple[900]!;
    final backgroundColor = isDarkMode ? Color(0xFF121212) : Color(0xFFF5F5F5);
    final cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[600]!;
    final correctColor = isDarkMode ? Colors.green[400]! : Colors.green[600]!;
    final wrongColor = isDarkMode ? Colors.red[400]! : Colors.red[600]!;

    if (_isLoading) {
      return Scaffold(
        appBar: _buildAppBar(localizations, primaryDarkColor),
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                strokeWidth: 5,
              ),
              const SizedBox(height: 28),
              Text(
                localizations.loadingQuestions,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _getLoadingSubtitle(localizations),
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar(localizations, primaryDarkColor),
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 80, color: wrongColor),
                const SizedBox(height: 28),
                Text(
                  localizations.noQuestionsAvailable,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.noQuestionsDescription,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: _fetchQuestions,
                  icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                  label: Text(
                    localizations.retry,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    shadowColor: primaryColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: _buildAppBar(localizations, primaryDarkColor),
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background decorative elements
          if (!isDarkMode) ...[
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [primaryColor.withOpacity(0.15), Colors.transparent],
                    radius: 0.8,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [primaryColor.withOpacity(0.15), Colors.transparent],
                    radius: 0.8,
                  ),
                ),
              ),
            ),
          ],

          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with category and progress
                _buildQuizHeader(localizations, primaryColor, textColor),
                const SizedBox(height: 28),

                // Question card
                _buildQuestionCard(currentQuestion, cardColor, primaryColor, textColor,localizations),
                const SizedBox(height: 28),

                // Answer options
                ...currentQuestion.options.map<Widget>((option) {
                  return _buildAnswerOption(
                    option: option,
                    currentQuestion: currentQuestion,
                    isDarkMode: isDarkMode,
                    correctColor: correctColor,
                    wrongColor: wrongColor,
                    textColor: textColor,
                    cardColor: cardColor,
                    primaryColor: primaryColor,
                  );
                }).toList(),
              ],
            ),
          ),

          // Timer
          Positioned(
            top: 20,
            right: 20,
            child: _buildTimer(primaryColor),
          ),

          // Next/Results button
          if (_selectedAnswer != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      backgroundColor.withOpacity(0.0),
                      backgroundColor,
                    ],
                  ),
                ),
                child: ElevatedButton.icon(
                  onPressed: _currentQuestionIndex < _questions.length - 1
                      ? _nextQuestion
                      : _endQuiz,
                  icon: Icon(
                    _currentQuestionIndex < _questions.length - 1
                        ? Icons.arrow_forward_rounded
                        : Icons.emoji_events_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: Text(
                    _currentQuestionIndex < _questions.length - 1
                        ? localizations.nextQuestion
                        : localizations.viewResults,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: primaryColor.withOpacity(0.6),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}