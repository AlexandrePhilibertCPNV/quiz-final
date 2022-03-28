import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quiz/services/question_repository.dart';
import 'package:quiz/models/question.dart';

class RemoteQuestionRepository implements QuestionRepository {
  final Uri _url;

  RemoteQuestionRepository(this._url);

  @override
  Future<Question> fetch() async {
    final response = await http.get(_url);

    if (response.statusCode >= 300) {
      throw Exception('Please handle me');
    }

    return Question.fromJson(jsonDecode(response.body));
  }
}
