import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/screens/home_screen.dart';
import 'package:quizflutter/utils/localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizSettings(),
      child: Consumer<QuizSettings>(
        builder: (context, settings, _) {
          return MaterialApp(
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
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}