import 'package:card_learning/blocs/card_learning/card_learning_cubit.dart';
import 'package:card_learning/blocs/card_learning/card_learning_state.dart';
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
    context.read<CardLearningCubit>().fetchLatestFlashCardsFromCardBox();

    _learningWidget(List<FlashCard> cards) {
      FlashCard currentCard = cards[context.read<CardLearningCubit>().currentCardIndex];

      return Column(
        children: [
          SafeArea(
              child: Card(
            elevation: 5,
            child: Column(
              children: [
                Text(currentCard.questionText.toString()),
                Text(currentCard.solutionText),
                Text(''),
                Text(currentCard.timesTested.toString()),
                Text("lastTimeTested: " + currentCard.lastTimeTested.toIso8601String().toString()),
                Text("timestGotRight: " + currentCard.timesGotRight.toString()),
                Text("timesGotWrong: " + currentCard.timesGotWrong.toString()),
              ],
            ),
          )),
          Center(
            child: Wrap(
              children: [
                ElevatedButton(
                  child: const Text('bad'),
                  onPressed: () async {
                    await context.read<CardLearningCubit>().currentCardGuessedWrong();
                    await context.read<CardLearningCubit>().switchToNextCard();
                  },
                ),
                ElevatedButton(
                  child: const Text('good'),
                  onPressed: () async {
                    await context.read<CardLearningCubit>().currentCardGuessedRight();
                    await context.read<CardLearningCubit>().switchToNextCard();
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Learning'),
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<CardLearningCubit, CardLearningState>(
            builder: (context, state) {
              switch (state.status) {
                case CardLearningStatus.loading:
                  return Center(child: CircularProgressIndicator());
                case CardLearningStatus.failure:
                  return Center(child: Text('Something went wrong'));
                case CardLearningStatus.success:
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
}
