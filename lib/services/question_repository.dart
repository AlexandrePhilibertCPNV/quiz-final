import 'package:quiz/models/question.dart';

abstract class QuestionRepository {
  Future<Question> fetch();
}
