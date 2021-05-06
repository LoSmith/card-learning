import 'package:card_learning/blocs/card_learning/card_learning_cubit.dart';
import 'package:card_learning/blocs/card_learning/card_learning_state.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/widgets/flash_card_side_widget.dart';

// import 'package:card_learning/widgets/flash_card_side_widget.dart';
// import 'package:card_learning/widgets/flip_view_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardLearningScreen extends StatefulWidget {
  @override
  _CardLearningScreenState createState() => _CardLearningScreenState();
}

class _CardLearningScreenState extends State<CardLearningScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<CardLearningCubit>().fetchSessionCards(10);

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Learning'),
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<CardLearningCubit, CardLearningState>(
            builder: (context, state) {
              if (state is CardLearningStateInitial) {
                return Column(
                  children: [
                    Text('initial'),
                    _loadingWidget(),
                  ],
                );
              } else if (state is CardLearningStateLoading) {
                return _loadingWidget();
              } else if (state is CardLearningStateSuccess) {
                return _learningWidget(state.currentCard);
              } else {
                return _loadingWidget();
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget _loadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  _learningWidget(FlashCard card) {
    GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

    return Column(
      children: [
        Center(
          child: Wrap(
            children: [
              ElevatedButton(
                child: const Text('bad'),
                onPressed: () async {
                  await context
                      .read<CardLearningCubit>()
                      .currentCardGuessedWrong();
                  await context.read<CardLearningCubit>().switchToNextCard();
                  flipCardKey.currentState!.isFront = true;
                  print('pressed bad');
                },
              ),
              ElevatedButton(
                child: const Text('good'),
                onPressed: () async {
                  await context
                      .read<CardLearningCubit>()
                      .currentCardGuessedRight();
                  await context.read<CardLearningCubit>().switchToNextCard();
                  flipCardKey.currentState!.isFront = true;
                  print('pressed good');
                },
              ),
            ],
          ),
        ),
        test(card, flipCardKey),
        // FlipView(
        //         key: flipCardKey,
        //         front: FlashCardSide(currentCard.questionText,
        //             currentCard.questionAddition, currentCard.questionImage),
        //         back: FlashCardSide(currentCard.solutionText,
        //             currentCard.solutionText, currentCard.solutionImage)),
      ],
    );
  }

  Widget test(FlashCard card, Key flipCardKey) => FlipCard(
      key: flipCardKey,
      direction: FlipDirection.VERTICAL, // default
      front: FlashCardSide(card.questionText, card.questionAddition, 'front'),
      back: FlashCardSide(card.solutionText, card.solutionText, 'back'));
}
