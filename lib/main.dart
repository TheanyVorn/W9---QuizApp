import 'package:flutter/material.dart';
import 'package:test/data/repositories/quiz_repository.dart';
import 'package:test/models/quiz.dart';
import 'package:test/ui/screens/welcome_screen.dart';
import 'package:test/ui/screens/question_screen.dart';
import 'package:test/ui/screens/results_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  // State management
  AppScreen currentScreen = AppScreen.welcome;
  Quiz? quiz;
  QuizResult? quizResult;
  bool isLoading = false;

  final QuizRepository _repository = QuizRepository();

  @override
  void initState() {
    super.initState();
  }

  // Navigate to quiz questions
  Future<void> _startQuiz() async {
    setState(() {
      isLoading = true;
    });

    try {
      final loadedQuiz = await _repository.getQuiz();
      setState(() {
        quiz = loadedQuiz;
        currentScreen = AppScreen.question;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

  // Handle quiz completion and show results
  void _completeQuiz(List<QuestionResult> results) {
    final score = results.where((r) => r.isCorrect).length;

    setState(() {
      quizResult = QuizResult(
        score: score,
        totalQuestions: quiz!.totalQuestions,
        questionResults: results,
      );
      currentScreen = AppScreen.results;
    });
  }

  // Restart quiz - go back to welcome
  void _restartQuiz() {
    setState(() {
      currentScreen = AppScreen.welcome;
      quiz = null;
      quizResult = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade700],
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

    // Navigate between screens based on state
    switch (currentScreen) {
      case AppScreen.welcome:
        return WelcomeScreen(onStartQuiz: _startQuiz);
      case AppScreen.question:
        return quiz != null
            ? QuestionScreen(
                questions: quiz!.questions,
                onQuizComplete: _completeQuiz,
              )
            : const SizedBox();
      case AppScreen.results:
        return quizResult != null
            ? ResultsScreen(
                quizResult: quizResult!,
                onRestartQuiz: _restartQuiz,
              )
            : const SizedBox();
    }
  }
}

enum AppScreen { welcome, question, results }
