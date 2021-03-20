import 'package:flutter/cupertino.dart';

class FlashCard {
  String question;
  String solution;

  bool isSwipedOff;

  FlashCard({
    @required this.question,
    @required this.solution,
    this.isSwipedOff = false,
  });
}
