import 'package:flutter/material.dart';
import 'package:test/models/quiz.dart';
import 'package:test/ui/widgets/app_button.dart';

class QuestionScreen extends StatefulWidget {
  final List<Question> questions;
  final Function(List<QuestionResult>) onQuizComplete;

  const QuestionScreen({
    super.key,
    required this.questions,
    required this.onQuizComplete,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  late List<QuestionResult> results;

  @override
  void initState() {
    super.initState();
    results = [];
  }

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void _nextQuestion() {
    final currentQuestion = widget.questions[currentQuestionIndex];
    final isCorrect = selectedAnswer == currentQuestion.correctAnswer;

    results.add(
      QuestionResult(
        question: currentQuestion,
        userAnswer: selectedAnswer ?? '',
        isCorrect: isCorrect,
      ),
    );

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      // Quiz completed
      widget.onQuizComplete(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade700],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Question counter
              Text(
                'Question ${currentQuestionIndex + 1} of ${widget.questions.length}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              // Question text
              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // Answer options
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    final isSelected = selectedAnswer == option;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () => _selectAnswer(option),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.white54,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: isSelected ? Colors.blue : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              // Next button
              AppButton(
                label: currentQuestionIndex == widget.questions.length - 1
                    ? 'Finish'
                    : 'Next',
                onPressed: selectedAnswer != null ? _nextQuestion : () {},
                backgroundColor: selectedAnswer != null
                    ? Colors.white
                    : Colors.grey,
                textColor: Colors.blue,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
