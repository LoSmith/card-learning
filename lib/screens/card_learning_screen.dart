import 'package:card_learning/blocs/card_learning/card_learning_cubit.dart';
import 'package:card_learning/blocs/card_list/card_list_cubit.dart';
import 'package:card_learning/blocs/card_list/card_list_state.dart';
import 'package:card_learning/blocs/selected_card_box/selected_card_box_cubit.dart';
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
    var selectedBoxId = context.read<SelectedCardBoxCubit>().selectedCardBoxId;
    var currentCardIndex = context.read<CardLearningCubit>().currentCardIndex;
    context.read<CardLearningCubit>().fetchLatestFlashCardsFromCardBox(selectedBoxId);

    _learningWidget(String selectedBoxId, List<FlashCard> cards) {
      FlashCard currentCard = cards[context.read<CardLearningCubit>().currentCardIndex];

      return Column(
        children: [
          SafeArea(
              child: Card(
            elevation: 5,
            child: Column(
              children: [
                Text(currentCard.questionText),
                Text(currentCard.solutionText),
                Text(''),
                Text(currentCard.timesTested.toString()),
                Text(currentCard.lastTimeTested.toString()),
              ],
            ),
          )),
          Center(
            child: Wrap(
              children: [
                ElevatedButton(
                  child: const Text('bad'),
                  onPressed: () async {
                    var tmp = context.read<CardLearningCubit>().currentCardIndex;
                    await context.read<CardLearningCubit>().currentCardGuessedWrong(selectedBoxId);
                    await context.read<CardLearningCubit>().switchToNextCard();
                    setState(() {});
                  },
                ),
                ElevatedButton(
                  child: const Text('good'),
                  onPressed: () {},
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
          child: BlocBuilder<CardListCubit, CardListState>(
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
                  return _learningWidget(selectedBoxId, state.items);
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
