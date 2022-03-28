import 'package:flutter/material.dart';

import 'package:quiz/managers/navigation_manager.dart';
import 'package:quiz/pages/menu_page.dart';

void main() {
  NavigationManager.register();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
      navigatorKey: NavigationManager.instance.navigatorKey,
    );
  }
}
