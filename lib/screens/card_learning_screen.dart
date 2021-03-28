import 'package:card_learning/blocs/cardLearning_bloc.dart';
import 'package:card_learning/blocs/events/cardLearning_event.dart';
import 'package:card_learning/blocs/states/cardLearning_state.dart';
import 'package:card_learning/data/flashCard_repository/flashCard_repository.dart';
import 'package:card_learning/data/irepository.dart';
import 'package:card_learning/domain/models/flashCard.dart';
import 'package:card_learning/widgets/simple_flash_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class CardLearningScreen extends StatefulWidget {
  @override
  _CardLearningScreenState createState() => _CardLearningScreenState();
}

class _CardLearningScreenState extends State<CardLearningScreen> {
  CardLearningBloc _bloc;

  List<FlashCard> cards = [
    FlashCard("1", 'Front Text', 'Back Text'),
    FlashCard("2", 'I', 'Ich '),
    FlashCard("3", 'su', 'sein'),
    FlashCard("4", 'que', 'das'),
    FlashCard("5", 'que', 'das'),
    FlashCard("6", 'que', 'das'),
    FlashCard("7", 'que', 'das'),
  ];

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final flashCardRepository =
          RepositoryProvider.of<FlashCardRepository>(context);
      this._bloc = CardLearningBloc(flashCardRepository);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ElevatedButton(
              child: Text('Fetch User'),
              onPressed: () =>
                  this._bloc.add(CardLearningEventFetchNextFlashCard()),
            ),
            SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<CardLearningBloc, CardLearningState>(
                bloc: this._bloc,
                builder: (context, state) {
                  if (state.isFetching) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.hasNetworkError) {
                    return Text('Network error');
                  }

                  if (state.flashCards?.isEmpty ?? true) {
                    return Text('No flashCards');
                  }

                  return ListView(
                    children: [
                      for (final flashCard in state.flashCards)
                        Text(
                          flashCard.question,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
        // body: Container(
        //     height: MediaQuery.of(context).size.height * 0.7,
        //     child: TinderSwapCard(
        //       orientation: AmassOrientation.BOTTOM,
        //       totalNum: this.cards.length,
        //       stackNum: 4,
        //       swipeEdge: 4.0,
        //       maxWidth: MediaQuery.of(context).size.width * 0.9,
        //       maxHeight: MediaQuery.of(context).size.width * 0.9,
        //       minWidth: MediaQuery.of(context).size.width * 0.8,
        //       minHeight: MediaQuery.of(context).size.width * 0.8,
        //       cardBuilder: (context, index) => SimpleFlashCardWidget(
        //         flashCard: this.cards[index],
        //       ),
        //       // cardController: controller = CardController(),
        //       swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
        //         if (align.x < 0) {
        //         } else if (align.x > 0) {}
        //       },
        //       swipeCompleteCallback:
        //           (CardSwipeOrientation orientaion, int index) {
        //         if (orientaion == CardSwipeOrientation.RIGHT) {
        //           print('swiped right');
        //         } else {
        //           print('swiped left');
        //         }
        //       },
        //       swipeUp: false,
        //       swipeDown: false,
        //       allowVerticalMovement: true,
        //     )),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => this._bloc.add(CardLearningEventFetchNextFlashCard()),
        // ),
      ),
    );
  }
}
