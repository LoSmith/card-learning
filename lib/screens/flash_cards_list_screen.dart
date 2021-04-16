import 'package:card_learning/blocs/flash_cards/flash_card_repository_cubit.dart';
import 'package:card_learning/blocs/flash_cards/flash_card_repository_state.dart';
import 'package:card_learning/blocs/learning_card_boxes/learning_card_boxes_cubit.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_remote_cards_list_screen.dart';

class FlashCardsListScreen extends StatefulWidget {
  @override
  _FlashCardsListScreenState createState() => _FlashCardsListScreenState();
}

class _FlashCardsListScreenState extends State<FlashCardsListScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<FlashCardRepositoryCubit, FlashCardRepositoryState>(
            builder: (context, state) {
              switch (state.status) {
                case FlashCardRepositoryStatus.loading:
                  return Center(child: CircularProgressIndicator());
                  break;

                case FlashCardRepositoryStatus.hasNetworkError:
                  return Text('Network error');
                  break;

                case FlashCardRepositoryStatus.success:
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
        Wrap(children: [
          ElevatedButton(
            child: const Text('deleteCards'),
            onPressed: () {
              context.read<FlashCardRepositoryCubit>().deleteAllCards();
            },
          ),
          ElevatedButton(
            child: const Text('pushDummyBox'),
            onPressed: () {
              context
                  .read<LearningCardBoxesCubit>()
                  .createLearningCardBox(LearningCardBox('newId', []));
            },
          ),
          ElevatedButton(
            child: const Text('loadRemoteCards'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FetchRemoteCardsListScreen(
                      onSave: (fetchUrl) {
                        context
                            .read<FlashCardRepositoryCubit>()
                            .importJsonDataFromRemoteUrl(fetchUrl);
                      },
                    ),
                  ));
            },
          ),
        ]),
      ]),
    );
  }

  ListView _flashCardListView(FlashCardRepositoryState state) {
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
          ),
        Spacer(),
      ],
    );
  }
}
