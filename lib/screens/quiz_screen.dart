import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/models/question.dart';
import 'package:quizflutter/screens/results_screen.dart';
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
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _remainingTime = 20;
  Timer? _timer;
  String? _selectedAnswer;
  bool _isAnswerCorrect = false;
  bool _isLoading = true;
  List<Question> _questions = [];
  List<bool?> _answersCorrectness = [];
  late AudioPlayer _audioPlayer; // Initialiser AudioPlayer

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Créer une instance d'AudioPlayer
    _fetchQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose(); // Nettoyer AudioPlayer
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
          SnackBar(content: Text('Failed to load questions')),
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
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

      // Jouer le son approprié
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

  void _endQuiz() {
    final score = _answersCorrectness.where((answer) => answer == true).length;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: score,
          totalQuestions: _questions.length,
          questions: _questions,
          answersCorrectness: _answersCorrectness,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.quiz),
          backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.quiz),
          backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
        ),
        body: Center(child: Text('No questions available')),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

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
              '${localizations.question} ${_currentQuestionIndex + 1}/${_questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              currentQuestion.question,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '${localizations.timeRemaining}: ${_remainingTime}s',
              style: const TextStyle(fontSize: 14, color: Colors.red),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _remainingTime / 20,
              color: _remainingTime > 10 ? Colors.green : Colors.red,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            ...currentQuestion.options.map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: _selectedAnswer == null
                      ? () => _selectAnswer(option)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedAnswer == option
                        ? (_isAnswerCorrect ? Colors.green : Colors.red)
                        : null,
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
            if (_selectedAnswer != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isAnswerCorrect
                        ? localizations.correct
                        : localizations.wrong,
                    style: TextStyle(
                      color: _isAnswerCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_currentQuestionIndex < _questions.length - 1)
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      child: Text(localizations.next),
                    )
                  else
                    ElevatedButton(
                      onPressed: _endQuiz,
                      child: Text(localizations.finish),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}