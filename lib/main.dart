import 'package:flutter/material.dart';
import 'page/card_learning_page.dart';

class LearningCard {
  String front;
  String back;

  LearningCard({this.front, this.back});
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipCard',
      theme: ThemeData.light(),
      home: LearnCardsPage(),
    );
  }
}
