import 'package:card_learning/models/flash_card.dart';
import 'package:flutter/material.dart';

class SimpleFlashCardWidget extends StatelessWidget {
  final FlashCard flashCard;
  SimpleFlashCardWidget({this.flashCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [Text(flashCard.question), Text(flashCard.solution)],
        ),
      ),
    );
  }
}
