import 'dart:async';

import 'package:quiz/services/question_repository.dart';
import 'package:quiz/managers/warrior_quiz_session.dart';

class NinjaQuizSession extends WarriorQuizSession {
  late final Timer _timer;
  final _maxTickCount = 4;
  var _currentTickCount = 0;

  NinjaQuizSession({required QuestionRepository questionRepository})
      : super(questionRepository: questionRepository, totalQuestionCount: 15) {
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _tick(Timer timer) {
    if (_currentTickCount >= _maxTickCount) return;

    _currentTickCount++;
    if (_currentTickCount == _maxTickCount) {
      $nextQuestion();
    }
    notifyListeners();
  }

  @override
  void $nextQuestion() {
    _currentTickCount = 0;
    super.$nextQuestion();
  }

  @override
  void $stop() {
    _timer.cancel();
    super.$stop();
  }

  @override
  String get info => "${_maxTickCount - _currentTickCount} - ${super.info}";
}
