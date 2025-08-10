
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/chatbot_provider.dart';
import 'package:flutter_project/provider/lesson_provider.dart';
import 'package:flutter_project/provider/profile_provider.dart';
import 'package:flutter_project/provider/quiz_provider.dart';
import 'package:flutter_project/provider/streak_provider.dart';
import 'package:flutter_project/provider/user_progres_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/screens/splash_screen.dart';
import 'core/constants.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await NotificationService.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
        ChangeNotifierProvider(create: (_) => StreakProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => UserProgress()),
        ChangeNotifierProvider(create: (_) => ChatBotProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryRed,
        scaffoldBackgroundColor: white,
        canvasColor: white,
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: primaryDark,
          displayColor: primaryDark,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

