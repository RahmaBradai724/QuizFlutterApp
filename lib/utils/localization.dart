import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

// ignore: prefer_relative_imports
import 'package:quizflutter/utils/localization.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Retrieves the [AppLocalizations] instance from the given [context].
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// The delegate for this localization class, used by [MaterialApp].
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  /// Map of localized strings for supported languages (en, fr, ar).
  /// Consider externalizing to JSON files for scalability if the list grows.
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'OpenTDB Quiz',
      'startQuiz': 'Start Quiz',
      'settings': 'Settings',
      'about': 'About',
      'stats': 'Statistics',
      'quiz': 'Quiz',
      'selectCategory': 'Select Category',
      'selectDifficulty': 'Select Difficulty',
      'selectQuestionCount': 'Select Question Count',
      'start': 'Start',
      'question': 'Question',
      'timeRemaining': 'Time Remaining',
      'results': 'Results',
      'yourScore': 'Your Score',
      'correctAnswer': 'Correct Answer',
      'playAgain': 'Play Again',
      'backToHome': 'Back to Home',
      'numberOfQuestions': 'Number of Questions',
      'easy': 'Easy',
      'medium': 'Medium',
      'hard': 'Hard',
      'any': 'Any',
      'next': 'Next',
      'finish': 'Finish',
      'correct': 'Correct!',
      'wrong': 'Wrong!',
      'timeUp': "Time's up!",
      'finalScore': 'Final Score',
      'correctAnswers': 'Correct Answers',
      'incorrectAnswers': 'Incorrect Answers',
      'darkMode': 'Dark Mode',
      'enableSounds': 'Enable Sounds',
      'enableVibrations': 'Enable Vibrations',
      'enableNotifications': 'Enable Notifications',
      'language': 'Language',
      'english': 'English',
      'french': 'French',
      'arabic': 'Arabic',
      'aboutContent':
      'This app uses the Open Trivia Database API to provide quiz questions.',
      'clearStats': 'Clear Statistics',
      'clearStatsConfirmation':
      'Are you sure you want to clear all statistics?',
      'noStats': 'No statistics available yet.',
      'bestScore': 'Best Score',
      'averageScore': 'Average Score',
      'totalQuizzes': 'Total Quizzes',
      'category': 'Category',
      'difficulty': 'Difficulty',
      'date': 'Date',
      'score': 'Score',
      'confirm': 'Confirm',
      'cancel': 'Cancel',
    },
    'fr': {
      'appTitle': 'Quiz OpenTDB',
      'startQuiz': 'Commencer le Quiz',
      'settings': 'Paramètres',
      'about': 'À propos',
      'stats': 'Statistiques',
      'quiz': 'Quiz',
      'selectCategory': 'Choisir une Catégorie',
      'selectDifficulty': 'Choisir la Difficulté',
      'selectQuestionCount': 'Sélectionner le Nombre de Questions',
      'start': 'Démarrer',
      'question': 'Question',
      'timeRemaining': 'Temps Restant',
      'results': 'Résultats',
      'yourScore': 'Votre Score',
      'correctAnswer': 'Réponse Correcte',
      'playAgain': 'Rejouer',
      'backToHome': "Retour à l'Accueil",
      'numberOfQuestions': 'Nombre de Questions',
      'easy': 'Facile',
      'medium': 'Moyen',
      'hard': 'Difficile',
      'any': 'Tous',
      'next': 'Suivant',
      'finish': 'Terminer',
      'correct': 'Correct !',
      'wrong': 'Faux !',
      'timeUp': 'Temps écoulé !',
      'finalScore': 'Score Final',
      'correctAnswers': 'Réponses Correctes',
      'incorrectAnswers': 'Réponses Incorrectes',
      'darkMode': 'Mode Sombre',
      'enableSounds': 'Activer les Sons',
      'enableVibrations': 'Activer les Vibrations',
      'enableNotifications': 'Activer les Notifications',
      'language': 'Langue',
      'english': 'Anglais',
      'french': 'Français',
      'arabic': 'Arabe',
      'aboutContent':
      "Cette application utilise l'API Open Trivia Database pour fournir des questions de quiz.",
      'clearStats': 'Effacer les Statistiques',
      'clearStatsConfirmation':
      'Êtes-vous sûr de vouloir effacer toutes les statistiques ?',
      'noStats': 'Aucune statistique disponible pour le moment.',
      'bestScore': 'Meilleur Score',
      'averageScore': 'Score Moyen',
      'totalQuizzes': 'Total des Quiz',
      'category': 'Catégorie',
      'difficulty': 'Difficulté',
      'date': 'Date',
      'score': 'Score',
      'confirm': 'Confirmer',
      'cancel': 'Annuler',
    },
    'ar': {
      'appTitle': 'مسابقة OpenTDB',
      'startQuiz': 'بدء المسابقة',
      'settings': 'الإعدادات',
      'about': 'حول',
      'stats': 'الإحصائيات',
      'quiz': 'اختبار',
      'selectCategory': 'اختر الفئة',
      'selectDifficulty': 'اختر الصعوبة',
      'selectQuestionCount': 'اختر عدد الأسئلة',
      'start': 'ابدأ',
      'question': 'سؤال',
      'timeRemaining': 'الوقت المتبقي',
      'results': 'النتائج',
      'yourScore': 'نتيجتك',
      'correctAnswer': 'الإجابة الصحيحة',
      'playAgain': 'العب مرة أخرى',
      'backToHome': 'العودة إلى الرئيسية',
      'numberOfQuestions': 'عدد الأسئلة',
      'easy': 'سهل',
      'medium': 'متوسط',
      'hard': 'صعب',
      'any': 'أي',
      'next': 'التالي',
      'finish': 'إنهاء',
      'correct': 'صحيح!',
      'wrong': 'خطأ!',
      'timeUp': 'انتهى الوقت!',
      'finalScore': 'النتيجة النهائية',
      'correctAnswers': 'إجابات صحيحة',
      'incorrectAnswers': 'إجابات خاطئة',
      'darkMode': 'الوضع المظلم',
      'enableSounds': 'تفعيل الأصوات',
      'enableVibrations': 'تفعيل الاهتزازات',
      'enableNotifications': 'تفعيل الإشعارات',
      'language': 'اللغة',
      'english': 'الإنجليزية',
      'french': 'الفرنسية',
      'arabic': 'العربية',
      'aboutContent':
      'هذا التطبيق يستخدم واجهة برمجة تطبيقات Open Trivia Database لتوفير أسئلة المسابقة.',
      'clearStats': 'مسح الإحصائيات',
      'clearStatsConfirmation':
      'هل أنت متأكد أنك تريد مسح جميع الإحصائيات؟',
      'noStats': 'لا توجد إحصائيات متاحة بعد.',
      'bestScore': 'أفضل نتيجة',
      'averageScore': 'متوسط النتيجة',
      'totalQuizzes': 'إجمالي المسابقات',
      'category': 'الفئة',
      'difficulty': 'الصعوبة',
      'date': 'التاريخ',
      'score': 'النتيجة',
      'confirm': 'تأكيد',
      'cancel': 'إلغاء',
    },
  };

  /// Helper method to get localized string with fallback to English.
  String _getLocalizedString(String key) {
    final languageCode = _localizedValues.containsKey(locale.languageCode)
        ? locale.languageCode
        : 'en';
    return _localizedValues[languageCode]![key] ?? key;
  }

  // Getters for localized strings
  String get appTitle => _getLocalizedString('appTitle');
  String get startQuiz => _getLocalizedString('startQuiz');
  String get settings => _getLocalizedString('settings');
  String get about => _getLocalizedString('about');
  String get stats => _getLocalizedString('stats');
  String get quiz => _getLocalizedString('quiz');
  String get selectCategory => _getLocalizedString('selectCategory');
  String get selectDifficulty => _getLocalizedString('selectDifficulty');
  String get selectQuestionCount => _getLocalizedString('selectQuestionCount');
  String get start => _getLocalizedString('start');
  String get question => _getLocalizedString('question');
  String get timeRemaining => _getLocalizedString('timeRemaining');
  String get results => _getLocalizedString('results');
  String get yourScore => _getLocalizedString('yourScore');
  String get correctAnswer => _getLocalizedString('correctAnswer');
  String get playAgain => _getLocalizedString('playAgain');
  String get backToHome => _getLocalizedString('backToHome');
  String get numberOfQuestions => _getLocalizedString('numberOfQuestions');
  String get easy => _getLocalizedString('easy');
  String get medium => _getLocalizedString('medium');
  String get hard => _getLocalizedString('hard');
  String get any => _getLocalizedString('any');
  String get next => _getLocalizedString('next');
  String get finish => _getLocalizedString('finish');
  String get correct => _getLocalizedString('correct');
  String get wrong => _getLocalizedString('wrong');
  String get timeUp => _getLocalizedString('timeUp');
  String get finalScore => _getLocalizedString('finalScore');
  String get correctAnswers => _getLocalizedString('correctAnswers');
  String get incorrectAnswers => _getLocalizedString('incorrectAnswers');
  String get darkMode => _getLocalizedString('darkMode');
  String get enableSounds => _getLocalizedString('enableSounds');
  String get enableVibrations => _getLocalizedString('enableVibrations');
  String get enableNotifications => _getLocalizedString('enableNotifications');
  String get language => _getLocalizedString('language');
  String get english => _getLocalizedString('english');
  String get french => _getLocalizedString('french');
  String get arabic => _getLocalizedString('arabic');
  String get aboutContent => _getLocalizedString('aboutContent');
  String get clearStats => _getLocalizedString('clearStats');
  String get clearStatsConfirmation =>
      _getLocalizedString('clearStatsConfirmation');
  String get noStats => _getLocalizedString('noStats');
  String get bestScore => _getLocalizedString('bestScore');
  String get averageScore => _getLocalizedString('averageScore');
  String get totalQuizzes => _getLocalizedString('totalQuizzes');
  String get category => _getLocalizedString('category');
  String get difficulty => _getLocalizedString('difficulty');
  String get date => _getLocalizedString('date');
  String get score => _getLocalizedString('score');
  String get confirm => _getLocalizedString('confirm');
  String get cancel => _getLocalizedString('cancel');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'fr', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}