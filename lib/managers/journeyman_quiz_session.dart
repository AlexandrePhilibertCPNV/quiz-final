import 'package:quiz/models/question.dart';
import 'package:quiz/services/question_repository.dart';
import 'package:quiz/managers/quiz_session.dart';

class JourneymanQuizSession extends QuizSession {
  JourneymanQuizSession(
      {required QuestionRepository questionRepository, totalQuestionCount = 15})
      : super(
            questionRepository: questionRepository,
            totalQuestionCount: totalQuestionCount);

  @override
  void doAnswer(Question question, String answer) {
    if (question.isCorrectAnswer(answer)) {
      $score++;
      $nextQuestion();
    } else {
      $score--;
    }
  }
}
