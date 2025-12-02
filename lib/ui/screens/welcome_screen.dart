import 'package:flutter/material.dart';
import 'package:test/ui/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStartQuiz;

  const WelcomeScreen({super.key, required this.onStartQuiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade700],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '?',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '?  ?',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              AppButton(
                label: 'Start Quiz',
                onPressed: onStartQuiz,
                backgroundColor: Colors.white,
                textColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
