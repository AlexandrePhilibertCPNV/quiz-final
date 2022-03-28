import 'package:quiz/models/question.dart';
import 'package:quiz/managers/quiz_session.dart';
import 'package:quiz/services/question_repository.dart';

class RookieQuizSession extends QuizSession {
  RookieQuizSession(
      {required QuestionRepository questionRepository, totalQuestionCount = 10})
      : super(questionRepository: questionRepository, totalQuestionCount: 10);

  @override
  void doAnswer(Question question, String answer) {
    if (question.isCorrectAnswer(answer)) {
      $score++;
    }
    $nextQuestion();
  }
}
