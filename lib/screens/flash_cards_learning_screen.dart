import 'package:card_learning/blocs/flash_cards/flash_cards_cubit.dart';
import 'package:card_learning/blocs/flash_cards/flash_cards_state.dart';
import 'package:card_learning/models/flashCard.dart';
import 'package:card_learning/widgets/flip_flash_card_widget.dart';
import 'package:card_learning/widgets/simple_flash_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class FlashCardsLearningScreen extends StatefulWidget {
  @override
  _FlashCardsLearningScreenState createState() => _FlashCardsLearningScreenState();
}

class _FlashCardsLearningScreenState extends State<FlashCardsLearningScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<FlashCardsCubit, FlashCardsState>(
            builder: (context, state) {
              switch (state.status) {
                case FlashCardsStatus.loading:
                  return Center(child: CircularProgressIndicator());
                  break;

                case FlashCardsStatus.hasNetworkError:
                  return Text('Network error');
                  break;

                case FlashCardsStatus.success:
                  if (state.items?.isEmpty ?? true) {
                    return Text('No flashCards');
                  }
                  return _tinderFlashCards(state.items);
                  break;

                default:
                  return Column(
                      children: [Center(child: CircularProgressIndicator()), Text('test')]);
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget _tinderFlashCards(List<FlashCard> cards) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: TinderSwapCard(
          orientation: AmassOrientation.BOTTOM,
          totalNum: cards.length,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) => FlipFlashCard(
            flashCard: cards[index],
          ),
          // cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            if (align.x < 0) {
            } else if (align.x > 0) {}
          },
          swipeCompleteCallback: (CardSwipeOrientation orientaion, int index) {
            if (orientaion == CardSwipeOrientation.RIGHT) {
              print('swiped right');
            } else {
              print('swiped left');
            }
          },
          swipeUp: false,
          swipeDown: false,
          allowVerticalMovement: true,
          animDuration: 10,
        ));
  }
}
