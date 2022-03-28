import 'dart:async';

import 'package:quiz/services/question_repository.dart';
import 'package:quiz/managers/journeyman_quiz_session.dart';

class WarriorQuizSession extends JourneymanQuizSession {
  late final Timer _timer;
  final _maxTickCount = 30;
  var _currentTickCount = 0;

  WarriorQuizSession(
      {required QuestionRepository questionRepository, totalQuestionCount = 15})
      : super(
            questionRepository: questionRepository,
            totalQuestionCount: totalQuestionCount) {
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
      $stop();
    }
    notifyListeners();
  }

  @override
  void $stop() {
    _timer.cancel();
    super.$stop();
  }

  @override
  String get info => "${_maxTickCount - _currentTickCount}";
}
