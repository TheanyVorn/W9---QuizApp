import 'package:test/models/quiz.dart';

class QuizRepository {
  // Mock data - simulates loading from a data source
  Future<Quiz> getQuiz() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final questions = [
      Question(
        id: 1,
        text: 'Who is the best teacher?',
        options: ['Ronan', 'Hongly', 'Leangsiv'],
        correctAnswer: 'Ronan',
      ),
      Question(
        id: 2,
        text: 'What is the best color?',
        options: ['Blue', 'Red', 'Green'],
        correctAnswer: 'Blue',
      ),
      Question(
        id: 3,
        text: 'What is 2 + 2?',
        options: ['3', '4', '5'],
        correctAnswer: '4',
      ),
    ];

    return Quiz(questions: questions);
  }
}
