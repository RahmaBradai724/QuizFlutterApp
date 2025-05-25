import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'scoresHistory': 'Scores History',
      'noScoresYet': 'No scores recorded yet',
      'viewScores': 'View Scores',
      'scoresCleared': 'All scores have been cleared',
      'playerName': 'Player Name',
      'welcomeSubtitle': 'Test your knowledge with our interactive quiz!',
      'nameRequired': 'Please enter your name to continue',
      'enjoyTheExperience': 'Enjoy the experience!',
      'appTitle': 'OpenTDB Quiz',
      'startQuiz': 'Start Quiz',
      'settings': 'Settings',
      'about': 'About',
      'stats': 'Statistics',
      'quiz': 'Quiz',
      'quizSetup': 'Quiz Setup',
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
      'nextQuestion': 'Next Question',
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
      'welcomeMessage': 'Welcome to the Quiz App!',
      'aboutAppDescription':
      'OpenTDB Quiz is a fun and educational app built with Flutter. Test your knowledge across various categories with questions fetched from the Open Trivia Database API.',
      'aboutApiTitle': 'About OpenTDB API',
      'aboutApiDescription':
      'The Open Trivia Database provides a free API with thousands of trivia questions across multiple categories and difficulty levels.',
      'visitApiWebsite': 'Visit OpenTDB Website',
      'version': 'Version: 1.0.0',
      'errorLaunchingUrl': 'Could not launch URL',
      'shareApp': 'Share',
      'shareAppText': 'Check out this awesome quiz app!',
      'shareAppSubject': 'OpenTDB Quiz App',
      'features': 'Features',
      'multipleCategories': 'Multiple Categories',
      'categoriesDescription': 'Questions across various knowledge domains',
      'variousDifficulties': 'Difficulty Levels',
      'difficultiesDescription': 'From beginner to expert challenges',
      'multiLanguage': 'Multi-language',
      'languageDescription': 'Available in several languages',
      'detailedStats': 'Detailed Statistics',
      'statsDescription': 'Track your progress over time',
      'developer': 'Developer',
      'developerDescription': 'This app was developed with Flutter by [Your Name].',
      'contact': 'Contact',
      'quizCompleted': 'Quiz Completed',
      'yourName': 'Your Name',
      'viewDetails': 'View Details',
      'detailedResults': 'Detailed Results',
      'yourAnswer': 'Your Answer',
      'save': 'Save',
      'scoreCategories': 'Score Categories',
      'filterByDifficulty': 'Filter by difficulty',
      'noScoresRecorded': 'No scores recorded yet',
      'difficulties': 'Difficulties',
      'allDifficulties': 'All difficulties',
      'welcomeToQuiz': 'Welcome to Quiz App',
      'enterYourName': 'Enter your name',
      'viewRankings': 'View Rankings',
      'viewResults': 'View Results',
      'loadingQuestions': 'Loading questions...',
      'noQuestionsAvailable': 'No questions available',
      'retry': 'Retry',
      'quizInfo': 'Quiz Information',
      'ok': 'OK',
      'loadingRandomQuestions': 'Loading random quiz questions...',
      'noQuestionsDescription':
      'Couldn’t fetch questions. Please check your connection or try again.',
    },
    'fr': {
      'scoresHistory': 'Historique des scores',
      'noScoresYet': 'Aucun score enregistré',
      'viewScores': 'Voir les scores',
      'scoresCleared': 'Tous les scores ont été effacés',
      'playerName': 'Nom du joueur',
      'welcomeSubtitle': 'Testez vos connaissances avec notre quiz interactif !',
      'nameRequired': 'Veuillez entrer votre nom pour continuer',
      'enjoyTheExperience': 'Profitez de l\'expérience !',
      'appTitle': 'Quiz OpenTDB',
      'startQuiz': 'Commencer le Quiz',
      'settings': 'Paramètres',
      'about': 'À propos',
      'stats': 'Statistiques',
      'quiz': 'Quiz',
      'quizSetup': 'Configuration du Quiz',
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
      'nextQuestion': 'Question Suivante',
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
      'welcomeMessage': 'Bienvenue dans l\'Application de Quiz !',
      'aboutAppDescription':
      'Quiz OpenTDB est une application amusante et éducative construite avec Flutter.',
      'aboutApiTitle': 'À propos de l\'API OpenTDB',
      'aboutApiDescription':
      'La base de données Open Trivia fournit une API gratuite avec des milliers de questions.',
      'visitApiWebsite': 'Visiter le site OpenTDB',
      'version': 'Version : 1.0.0',
      'errorLaunchingUrl': 'Impossible d\'ouvrir l\'URL',
      'shareApp': 'Partager',
      'shareAppText': 'Découvrez cette super application de quiz !',
      'shareAppSubject': 'Application Quiz OpenTDB',
      'features': 'Fonctionnalités',
      'multipleCategories': 'Catégories multiples',
      'categoriesDescription': 'Questions sur divers sujets',
      'variousDifficulties': 'Niveaux de difficulté',
      'difficultiesDescription': 'Des questions faciles à difficiles',
      'multiLanguage': 'Multilingue',
      'languageDescription': 'Disponible en plusieurs langues',
      'detailedStats': 'Statistiques détaillées',
      'statsDescription': 'Suivez votre progression',
      'developer': 'Développeur',
      'developerDescription': 'Développé avec Flutter',
      'contact': 'Contact',
      'quizCompleted': 'Quiz Terminé',
      'yourName': 'Votre Nom',
      'viewDetails': 'Voir les détails',
      'detailedResults': 'Résultats détaillés',
      'yourAnswer': 'Votre réponse',
      'save': 'Enregistrer',
      'scoreCategories': 'Catégories de scores',
      'filterByDifficulty': 'Filtrer par difficulté',
      'noScoresRecorded': 'Aucun score enregistré pour le moment',
      'difficulties': 'Difficultés',
      'allDifficulties': 'Toutes les difficultés',
      'welcomeToQuiz': 'Bienvenue dans l\'application de quiz',
      'enterYourName': 'Entrez votre nom',
      'viewRankings': 'Voir les classements',
      'viewResults': 'Voir les Résultats',
      'loadingQuestions': 'Chargement des questions...',
      'noQuestionsAvailable': 'Aucune question disponible',
      'retry': 'Réessayer',
      'quizInfo': 'Informations sur le quiz',
      'ok': 'OK',
      'loadingRandomQuestions': 'Chargement de questions de quiz aléatoires...',
      'noQuestionsDescription':
      'Impossible de récupérer les questions. Veuillez vérifier votre connexion ou réessayer.',
    },
    'ar': {
      'scoresHistory': 'سجل النتائج',
      'noScoresYet': 'لا توجد نتائج مسجلة بعد',
      'viewScores': 'عرض النتائج',
      'scoresCleared': 'تم مسح جميع النتائج',
      'playerName': 'اسم اللاعب',
      'welcomeSubtitle': 'اختبر معلوماتك مع اختبارنا التفاعلي!',
      'nameRequired': 'الرجاء إدخال اسمك للمتابعة',
      'enjoyTheExperience': 'استمتع بالتجربة!',
      'appTitle': 'مسابقة OpenTDB',
      'startQuiz': 'بدء المسابقة',
      'settings': 'الإعدادات',
      'about': 'حول',
      'stats': 'الإحصائيات',
      'quiz': 'اختبار',
      'quizSetup': 'إعداد الاختبار',
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
      'nextQuestion': 'السؤال التالي',
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
      'welcomeMessage': 'مرحبًا بكم في تطبيق المسابقة!',
      'aboutAppDescription':
      'مسابقة OpenTDB هي تطبيق ممتع وتعليمي تم إنشاؤه باستخدام Flutter.',
      'aboutApiTitle': 'حول واجهة برمجة التطبيقات OpenTDB',
      'aboutApiDescription':
      'قاعدة بيانات Open Trivia توفر واجهة برمجة تطبيقات مجانية تحتوي على آلاف الأسئلة.',
      'visitApiWebsite': 'زوروا موقع OpenTDB',
      'version': 'الإصدار: 1.0.0',
      'errorLaunchingUrl': 'تعذر فتح الرابط',
      'shareApp': 'مشاركة',
      'shareAppText': 'اكتشف هذا التطبيق الرائع للمسابقات!',
      'shareAppSubject': 'تطبيق مسابقة OpenTDB',
      'features': 'الميزات',
      'multipleCategories': 'فئات متعددة',
      'categoriesDescription': 'أسئلة في مواضيع متنوعة',
      'variousDifficulties': 'مستويات الصعوبة',
      'difficultiesDescription': 'من الأسئلة السهلة إلى الصعبة',
      'multiLanguage': 'متعدد اللغات',
      'languageDescription': 'متاح بعدة لغات',
      'detailedStats': 'إحصائيات مفصلة',
      'statsDescription': 'تابع تقدمك',
      'developer': 'المطور',
      'developerDescription': 'مطور باستخدام Flutter',
      'contact': 'اتصل',
      'quizCompleted': 'تم الانتهاء من الاختبار',
      'yourName': 'اسمك',
      'viewDetails': 'عرض التفاصيل',
      'detailedResults': 'النتائج التفصيلية',
      'yourAnswer': 'إجابتك',
      'save': 'حفظ',
      'scoreCategories': 'فئات النتائج',
      'filterByDifficulty': 'تصفية حسب الصعوبة',
      'noScoresRecorded': 'لم يتم تسجيل أي نتائج بعد',
      'difficulties': 'الصعوبات',
      'allDifficulties': 'جميع الصعوبات',
      'welcomeToQuiz': 'مرحبًا بتطبيق المسابقة',
      'enterYourName': 'أدخل اسمك',
      'viewRankings': 'عرض التصنيفات',
      'viewResults': 'عرض النتائج',
      'loadingQuestions': 'جارٍ تحميل الأسئلة...',
      'noQuestionsAvailable': 'لا توجد أسئلة متاحة',
      'retry': 'إعادة المحاولة',
      'quizInfo': 'معلومات الاختبار',
      'ok': 'موافق',
      'loadingRandomQuestions': 'جارٍ تحميل أسئلة اختبار عشوائية...',
      'noQuestionsDescription':
      'تعذر جلب الأسئلة. يرجى التحقق من اتصالك أو المحاولة مرة أخرى.',
    },
  };

  String _getLocalizedString(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key] ??
        'Missing translation: $key';
  }

  String get welcomeSubtitle => _getLocalizedString('welcomeSubtitle');
  String get nameRequired => _getLocalizedString('nameRequired');
  String get enjoyTheExperience => _getLocalizedString('enjoyTheExperience');
  String get appTitle => _getLocalizedString('appTitle');
  String get startQuiz => _getLocalizedString('startQuiz');
  String get settings => _getLocalizedString('settings');
  String get about => _getLocalizedString('about');
  String get stats => _getLocalizedString('stats');
  String get quiz => _getLocalizedString('quiz');
  String get quizSetup => _getLocalizedString('quizSetup');
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
  String get nextQuestion => _getLocalizedString('nextQuestion');
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
  String get welcomeMessage => _getLocalizedString('welcomeMessage');
  String get aboutAppDescription => _getLocalizedString('aboutAppDescription');
  String get aboutApiTitle => _getLocalizedString('aboutApiTitle');
  String get aboutApiDescription => _getLocalizedString('aboutApiDescription');
  String get visitApiWebsite => _getLocalizedString('visitApiWebsite');
  String get version => _getLocalizedString('version');
  String get errorLaunchingUrl => _getLocalizedString('errorLaunchingUrl');
  String get shareApp => _getLocalizedString('shareApp');
  String get shareAppText => _getLocalizedString('shareAppText');
  String get shareAppSubject => _getLocalizedString('shareAppSubject');
  String get features => _getLocalizedString('features');
  String get multipleCategories => _getLocalizedString('multipleCategories');
  String get categoriesDescription => _getLocalizedString('categoriesDescription');
  String get variousDifficulties => _getLocalizedString('variousDifficulties');
  String get difficultiesDescription =>
      _getLocalizedString('difficultiesDescription');
  String get multiLanguage => _getLocalizedString('multiLanguage');
  String get languageDescription => _getLocalizedString('languageDescription');
  String get detailedStats => _getLocalizedString('detailedStats');
  String get statsDescription => _getLocalizedString('statsDescription');
  String get developer => _getLocalizedString('developer');
  String get developerDescription => _getLocalizedString('developerDescription');
  String get contact => _getLocalizedString('contact');
  String get quizCompleted => _getLocalizedString('quizCompleted');
  String get yourName => _getLocalizedString('yourName');
  String get viewDetails => _getLocalizedString('viewDetails');
  String get detailedResults => _getLocalizedString('detailedResults');
  String get yourAnswer => _getLocalizedString('yourAnswer');
  String get save => _getLocalizedString('save');
  String get scoreCategories => _getLocalizedString('scoreCategories');
  String get filterByDifficulty => _getLocalizedString('filterByDifficulty');
  String get noScoresRecorded => _getLocalizedString('noScoresRecorded');
  String get difficulties => _getLocalizedString('difficulties');
  String get allDifficulties => _getLocalizedString('allDifficulties');
  String get welcomeToQuiz => _getLocalizedString('welcomeToQuiz');
  String get enterYourName => _getLocalizedString('enterYourName');
  String get viewRankings => _getLocalizedString('viewRankings');
  String get viewResults => _getLocalizedString('viewResults');
  String get loadingQuestions => _getLocalizedString('loadingQuestions');
  String get noQuestionsAvailable => _getLocalizedString('noQuestionsAvailable');
  String get retry => _getLocalizedString('retry');
  String get quizInfo => _getLocalizedString('quizInfo');
  String get ok => _getLocalizedString('ok');
  String get loadingRandomQuestions => _getLocalizedString('loadingRandomQuestions');
  String get noQuestionsDescription => _getLocalizedString('noQuestionsDescription');
  String get scoresHistory => 'Score history';
  String get noScoresYet => 'No score recorded';
  String get viewScores => 'View Scores';
  String get scoresCleared => _getLocalizedString('scoresCleared');
  String get playerName => _getLocalizedString('playerName');


}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}