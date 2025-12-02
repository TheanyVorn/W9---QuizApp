class Question {
  final int id;
  final String text;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  int get totalQuestions => questions.length;
}

class QuizResult {
  final int score;
  final int totalQuestions;
  final List<QuestionResult> questionResults;

  QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.questionResults,
  });

  double get percentage => (score / totalQuestions * 100);
}

class QuestionResult {
  final Question question;
  final String userAnswer;
  final bool isCorrect;

  QuestionResult({
    required this.question,
    required this.userAnswer,
    required this.isCorrect,
  });
}
