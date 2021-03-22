import 'package:card_learning/model/learnCard.dart';
import 'package:card_learning/widget/flip_flash_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class LearnCardsPage extends StatefulWidget {
  @override
  _LearnCardsPageState createState() => _LearnCardsPageState();
}

class _LearnCardsPageState extends State<LearnCardsPage> {
  List<FlashCard> cards = [
    FlashCard(question: 'Front Text', solution: 'Back Text'),
    FlashCard(question: 'I', solution: 'Ich '),
    FlashCard(question: 'su', solution: 'sein'),
    FlashCard(question: 'que', solution: 'das'),
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return Scaffold(
      // body: FlipFlashCardWidget(
      //   currentCard: cards[0],
      // ),
      body: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: TinderSwapCard(
            orientation: AmassOrientation.BOTTOM,
            totalNum: this.cards.length,
            stackNum: 2,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => FlipFlashCard(
              flashCard: this.cards[index],
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              if (align.x < 0) {
              } else if (align.x > 0) {}
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientaion, int index) {
              if (orientaion == CardSwipeOrientation.RIGHT) {
                print('swiped right');
              } else {
                print('swiped left');
              }
            },
            swipeUp: false,
            allowVerticalMovement: false,
            swipeDown: false,
          )),
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
