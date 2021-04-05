import 'package:card_learning/blocs/flash_cards/flash_cards_cubit.dart';
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
                  return _flashCardListView(state);
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

  ListView _flashCardListView(FlashCardsState state) {
    return ListView(
      children: [
        Text(state.items.length.toString()),
        for (final flashCard in state.items)
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
