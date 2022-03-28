import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:quiz/managers/quiz_session.dart';
import 'package:quiz/pages/menu_page.dart';

class GameoverPage extends StatelessWidget {
  const GameoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = GetIt.I.get<QuizSession>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz - Game Over"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("GAME OVER", textScaleFactor: 2.0),
              const Spacer(),
              const Text("Your score", textScaleFactor: 1.5),
              Text(
                "${session.score}",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                textScaleFactor: 2.0,
              ),
              const Spacer(),
              Text("For answering ${session.questionsCount} questions",
                  textScaleFactor: 1.5),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MenuPage())),
                child: const Text("Back to Menu",
                    textScaleFactor: 2.0, textAlign: TextAlign.center),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
