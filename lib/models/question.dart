class Question {
  String caption;
  List<String> answers;
  String hint;

  String _correctAnswer;

  Question(this.caption, this.answers, this._correctAnswer, [this.hint = ""]);

  factory Question.none() {
    return Question("", [], "");
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    var answers = json['answers'].cast<String>();
    return Question(
      json['caption'],
      answers,
      answers[json['correct_answer_index']],
      json['hint']
    );
  }

  bool isCorrectAnswer(String answer) {
    return _correctAnswer == answer;
  }
}
