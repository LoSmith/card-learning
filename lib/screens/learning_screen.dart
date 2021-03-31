import 'package:card_learning/blocs/cardLearning/cardLearning.dart';
import 'package:card_learning/blocs/cardLearning/cardLearning_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<CardLearningBloc, CardLearningState>(
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
            },
          ),
        ),
      ]),
    );
  }
}
