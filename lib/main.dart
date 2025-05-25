import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/screens/home_screen.dart';
import 'package:quizflutter/screens/welcome_screen.dart';
import 'package:quizflutter/utils/localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizflutter/models/score.dart';
import 'package:quizflutter/services/score_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Hive
  await Hive.initFlutter();

  // Enregistrer l'adaptateur pour Score
  Hive.registerAdapter(ScoreAdapter());

  // Ouvrir la boîte de stockage
  await Hive.openBox<Score>('scoresBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizSettings()),
        Provider(create: (_) => ScoreRepository()),
      ],
      child: Consumer<QuizSettings>(
        builder: (context, settings, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Pour enlever la bannière de debug
            locale: settings.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
              Locale('ar', ''),
            ],
            theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}