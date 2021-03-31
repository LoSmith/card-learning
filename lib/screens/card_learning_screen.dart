import 'package:card_learning/blocs/cardLearning/cardLearning.dart';
import 'package:card_learning/blocs/cardLearning/cardLearning_bloc.dart';
import 'package:card_learning/data/flashCard_repository/flashCard_repository.dart';
import 'package:card_learning/models/flashCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
