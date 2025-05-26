import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// Title of the application
  ///
  /// In en, this message translates to:
  /// **'OpenTDB Quiz'**
  String get appTitle;

  /// Label for the start quiz button
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get startQuiz;

  /// Title for the statistics screen
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// Title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Title for the about screen
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Welcome message on the home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Quiz App!'**
  String get welcomeMessage;

  /// Title for the quiz screen
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// Hint for category dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// Hint for difficulty dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Difficulty'**
  String get selectDifficulty;

  /// Hint for question count dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Question Count'**
  String get selectQuestionCount;

  /// Label for the start button
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Label for question number
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// Label for timer
  ///
  /// In en, this message translates to:
  /// **'Time Remaining'**
  String get timeRemaining;

  /// Title for the results screen
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// Label for score display
  ///
  /// In en, this message translates to:
  /// **'Your Score'**
  String get yourScore;

  /// Label for correct answer
  ///
  /// In en, this message translates to:
  /// **'Correct Answer'**
  String get correctAnswer;

  /// Label for play again button
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// Label for back to home button
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Label for number of questions
  ///
  /// In en, this message translates to:
  /// **'Number of Questions'**
  String get numberOfQuestions;

  /// Label for easy difficulty
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// Label for medium difficulty
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Label for hard difficulty
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// Label for any difficulty
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// Label for next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Label for finish button
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Message for correct answer
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// Message for wrong answer
  ///
  /// In en, this message translates to:
  /// **'Wrong!'**
  String get wrong;

  /// Message for time up
  ///
  /// In en, this message translates to:
  /// **'Time\'s up!'**
  String get timeUp;

  /// Label for final score
  ///
  /// In en, this message translates to:
  /// **'Final Score'**
  String get finalScore;

  /// Label for correct answers
  ///
  /// In en, this message translates to:
  /// **'Correct Answers'**
  String get correctAnswers;

  /// Label for incorrect answers
  ///
  /// In en, this message translates to:
  /// **'Incorrect Answers'**
  String get incorrectAnswers;

  /// Message shown when no statistics are available
  ///
  /// In en, this message translates to:
  /// **'No statistics available'**
  String get noStats;

  /// Label for the best score statistic
  ///
  /// In en, this message translates to:
  /// **'Best Score'**
  String get bestScore;

  /// Label for the average score statistic
  ///
  /// In en, this message translates to:
  /// **'Average Score'**
  String get averageScore;

  /// Label for the total number of quizzes
  ///
  /// In en, this message translates to:
  /// **'Total Quizzes'**
  String get totalQuizzes;

  /// Title for the clear statistics dialog
  ///
  /// In en, this message translates to:
  /// **'Clear Statistics'**
  String get clearStats;

  /// Confirmation message for clearing statistics
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all statistics?'**
  String get clearStatsConfirmation;

  /// Label for the cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Label for the confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Content for the about screen
  ///
  /// In en, this message translates to:
  /// **'This app uses the Open Trivia Database API to provide quiz questions.'**
  String get aboutContent;

  /// Description of the application on the about screen
  ///
  /// In en, this message translates to:
  /// **'OpenTDB Quiz is a fun and educational app built with Flutter. Test your knowledge across various categories with questions fetched from the Open Trivia Database API.'**
  String get aboutAppDescription;

  /// Title for the OpenTDB API section on the about screen
  ///
  /// In en, this message translates to:
  /// **'About OpenTDB API'**
  String get aboutApiTitle;

  /// Description of the OpenTDB API on the about screen
  ///
  /// In en, this message translates to:
  /// **'The Open Trivia Database (OpenTDB) provides a free API with thousands of trivia questions across multiple categories and difficulty levels, making it perfect for quiz applications like this one.'**
  String get aboutApiDescription;

  /// Label for the link to the OpenTDB website
  ///
  /// In en, this message translates to:
  /// **'Visit OpenTDB Website: https://opentdb.com'**
  String get visitApiWebsite;

  /// Error message when the URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Could not launch the URL'**
  String get errorLaunchingUrl;

  /// Application version displayed on the about screen
  ///
  /// In en, this message translates to:
  /// **'Version: 1.0.0+1'**
  String get version;

  /// Label for dark mode toggle
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Label for enabling sound effects
  ///
  /// In en, this message translates to:
  /// **'Enable Sounds'**
  String get enableSounds;

  /// Label for enabling vibration effects
  ///
  /// In en, this message translates to:
  /// **'Enable Vibrations'**
  String get enableVibrations;

  /// Label for enabling notifications
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// Label for language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label for English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Label for French language option
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// Label for Arabic language option
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
