import 'package:card_learning/blocs/cardLearning/cardLearning.dart';
import 'package:card_learning/blocs/cardLearning/cardLearning_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  CardLearningBloc _bloc;

  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ElevatedButton(
              child: Text('Add Cards'),
              onPressed: () => this._bloc.add(CardLearningEventCreateCard(
                  "id test", "question", "solution fdjsiofs")),
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
        ),
      ),
    );
  }
}
