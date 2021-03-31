import 'package:card_learning/screens/learning_screen.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LearningScreen(),
      floatingActionButton:
          FloatingActionButton(onPressed: () => print('object')),
    );
  }
}
