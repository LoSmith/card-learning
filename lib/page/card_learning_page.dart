import 'package:card_learning/data/cards.dart';
import 'package:card_learning/model/learnCard.dart';
import 'package:card_learning/widget/flip_flash_card_widget.dart';
import 'package:flutter/material.dart';

class LearnCardsPage extends StatefulWidget {
  @override
  _LearnCardsPageState createState() => _LearnCardsPageState();
}

class _LearnCardsPageState extends State<LearnCardsPage> {
  List<FlashCard> cards = spanishCards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlipFlashCardWidget(
        currentCard: cards[0],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(
              Icons.person,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Work',
            icon: Icon(
              Icons.work,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'messages',
            icon: Icon(
              Icons.message,
              color: Colors.grey,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
