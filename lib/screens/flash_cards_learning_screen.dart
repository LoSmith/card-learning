import 'package:card_learning/blocs/flash_cards/flash_cards_bloc.dart';
import 'package:card_learning/blocs/flash_cards/flash_cards_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocBuilder<FlashCardBloc, FlashCardState>(
            builder: (context, state) {
              if (state.isFetching) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.hasNetworkError) {
                return Text('Network error');
              }

              if (state.cards?.isEmpty ?? true) {
                return Text('No flashCards');
              }

              return _flashCardListView(state);
            },
          ),
        ),
      ]),
    );
  }

  ListView _flashCardListView(FlashCardState state) {
    return ListView(
      children: [
        for (final flashCard in state.cards)
          Column(
            children: [
              Text(
                flashCard.id,
                textAlign: TextAlign.center,
              ),
              Text(
                flashCard.question,
                textAlign: TextAlign.center,
              ),
              Text(
                flashCard.solution,
                textAlign: TextAlign.center,
              ),
            ],
          )
      ],
    );
  }
}
