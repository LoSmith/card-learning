import 'package:card_learning/screens/card_learning_screen.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardLearningScreen(),
      floatingActionButton:
          FloatingActionButton(onPressed: () => print('object')),
    );
  }
}
