import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz/managers/navigation_manager.dart';

import 'package:quiz/models/question.dart';
import 'package:quiz/pages/gameover_page.dart';
import 'package:quiz/services/question_repository.dart';

abstract class QuizSession
    with ChangeNotifier
    implements ValueListenable<QuizSession> {
  late final int _totalQuestionCount;
  late final QuestionRepository _questionRepository;
  late final StreamController<Question> _questionStreamController;

  var _currentQuestionCount = 0;
  var _hintRequested = false;

  // There's no `protected` visibility on Dart, so set it back to public, but start its name by the
  // dollar sign ($) which is legal but highly unlikely to be used for real public names.
  //https://stackoverflow.com/questions/28350655/how-do-i-emulate-protected-methods-in-dart
  var $score = 0;

  int get questionsCount => _totalQuestionCount;
  int get score => $score;
  bool get hintRequested => _hintRequested;
  String get info => "";

  Stream<Question> get questionStream => _questionStreamController.stream;

  QuizSession(
      {required QuestionRepository questionRepository,
      required int totalQuestionCount}) {
    _questionRepository = questionRepository;
    _totalQuestionCount = totalQuestionCount;
    _questionStreamController = StreamController();
  }

  // Here only to implement ValueListenable, will never be used.
  @override
  QuizSession get value => this;

  void start() {
    $nextQuestion();
  }

  // subclasses have to implement in regards to their game rules
  void doAnswer(Question question, String answer);

  void requestHint() {
    _hintRequested = true;
    notifyListeners();
  }

  void $nextQuestion() async {
    _currentQuestionCount++;
    if (_currentQuestionCount > _totalQuestionCount) {
      $stop();
    } else {
      _questionStreamController.add(await _questionRepository.fetch());
      _hintRequested = false;
      notifyListeners();
    }
  }

  void $stop() {
    NavigationManager.instance.navigateToReplacement(
        MaterialPageRoute(builder: (context) => const GameoverPage()));
  }
}
