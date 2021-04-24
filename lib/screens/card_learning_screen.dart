import 'package:card_learning/blocs/flash_cards/flash_card_repository_cubit.dart';
import 'package:card_learning/blocs/flash_cards/flash_card_repository_state.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardLearningScreen extends StatefulWidget {
  @override
  _CardLearningScreenState createState() => _CardLearningScreenState();
}

class _CardLearningScreenState extends State<CardLearningScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Learning'),
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<FlashCardRepositoryCubit, FlashCardRepositoryState>(
            builder: (context, state) {
              switch (state.status) {
                case FlashCardRepositoryStatus.loading:
                  return Center(child: CircularProgressIndicator());
                case FlashCardRepositoryStatus.failure:
                  return Center(child: Text('Something went wrong'));
                case FlashCardRepositoryStatus.success:
                  if (state.items.isEmpty) {
                    return Center(child: Text('No flashCards'));
                  }
                  return _learningWidget(state.items);
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

  Widget _learningWidget(List<FlashCard> cards) {
    var shownCard = cards[0];

    return Column(
      children: [
        Expanded(
          child: SafeArea(
              child: Row(
            children: [
              Text('${shownCard.questionText}'),
              Text(' - '),
              Text('${shownCard.solutionText}'),
            ],
          )),
        ),
        Wrap(
          children: [
            ElevatedButton(
              child: const Text('bad'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: const Text('good'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

//   Widget _tinderFlashCards(List<FlashCard> cards) {
//     return Container(
//         height: MediaQuery.of(context).size.height * 0.7,
//         child: TinderSwapCard(
//           orientation: AmassOrientation.BOTTOM,
//           totalNum: cards.length,
//           stackNum: 3,
//           swipeEdge: 4.0,
//           maxWidth: MediaQuery.of(context).size.width * 0.9,
//           maxHeight: MediaQuery.of(context).size.width * 0.9,
//           minWidth: MediaQuery.of(context).size.width * 0.8,
//           minHeight: MediaQuery.of(context).size.width * 0.8,
//           cardBuilder: (context, index) => FlipFlashCard(
//             flashCard: cards[index],
//           ),
//           // cardController: controller = CardController(),
//           swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
//             if (align.x < 0) {
//             } else if (align.x > 0) {}
//           },
//           swipeCompleteCallback: (CardSwipeOrientation orientaion, int index) {
//             if (orientaion == CardSwipeOrientation.RIGHT) {
//               print('swiped right');
//             } else {
//               print('swiped left');
//             }
//           },
//           swipeUp: false,
//           swipeDown: false,
//           allowVerticalMovement: true,
//           animDuration: 10,
//         ));
//   }
// }
}
