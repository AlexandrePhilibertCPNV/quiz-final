import 'package:quiz/models/question.dart';
import 'package:quiz/services/question_repository.dart';

class StaticQuestionRepository implements QuestionRepository {
  final _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you",
        ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];
  var _currentQuestionIndex = 0;

  @override
  Future<Question> fetch() async {
    _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    return _questions[_currentQuestionIndex];
  }
}
