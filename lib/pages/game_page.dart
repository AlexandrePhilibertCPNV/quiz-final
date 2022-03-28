import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import 'package:quiz/models/question.dart';
import 'package:quiz/managers/quiz_session.dart';

class GamePage extends StatelessWidget with GetItMixin {
  final QuizSession session;

  GamePage(this.session, {Key? key}) : super(key: key) {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton(session);

    session.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz - Game"),
      ),
      body: _buildSession(context),
    );
  }

  Widget _buildSession(BuildContext context) {
    final _ = watch(target: session);

    return Center(
        child:
            Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Text(session.info, textScaleFactor: 2.0),
      ),
      _QuestionView(session),
    ]));
  }
}

class _QuestionView extends StatelessWidget with GetItMixin {
  final QuizSession session;

  _QuestionView(this.session, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Connects the the QuestionManager event stream
    AsyncSnapshot<Question> snapshot =
        watchStream((QuizSession m) => m.questionStream, Question.none());

    if (snapshot.hasData) {
      return buildQuestion(context, snapshot.data!);
    } else if (snapshot.hasError) {
      return Center(
          child: Text('${snapshot.error}',
              style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: Theme.of(context).textTheme.headline3?.fontSize)));
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildQuestion(BuildContext context, Question question) {
    final answerButtons = question.answers.map((answer) {
      return ElevatedButton(
          onPressed: () => session.doAnswer(question, answer),
          child: SizedBox(
              width: double.infinity,
              child: Text(answer,
                  textScaleFactor: 2.0, textAlign: TextAlign.center)));
    });

    return Center(
      child: Column(
        children: <Widget>[
          const Spacer(),
          buildHint(context, question),
          const Spacer(),
          Text(question.caption, textScaleFactor: 2.0),
          const Spacer(),
          ...answerButtons,
          const Spacer(),
        ],
      ),
    );
  }

  Widget buildHint(BuildContext context, Question question) {
    if (session.hintRequested) {
      return Text(question.hint, textScaleFactor: 2.0);
    } else {
      return ElevatedButton(
        onPressed: () => session.requestHint(),
        child:
            const Text("?", textScaleFactor: 2.0, textAlign: TextAlign.center),
      );
    }
  }
}
