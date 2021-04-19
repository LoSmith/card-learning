import 'package:card_learning/blocs/card_box_list/card_box_list_state.dart';
import 'package:card_learning/blocs/flash_cards/flash_card_repository_cubit.dart';
import 'package:card_learning/blocs/flash_cards/flash_card_repository_state.dart';
import 'package:card_learning/blocs/selected_card_box/selected_card_box_cubit.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_remote_cards_screen.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.
    var selectedBoxId = context.read<SelectedCardBoxCubit>().selectedCardBoxId;
    context.read<FlashCardRepositoryCubit>().fetchLatestFlashCardsFromCardBox(selectedBoxId);
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 15),
        Container(
          child: Expanded(
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
                    return newDismissibleFlashCardView(context, state, selectedBoxId);
                    break;

                  default:
                    return Column(
                        children: [Center(child: CircularProgressIndicator()), Text('test')]);
                }
              },
            ),
          ),
        ),
        Wrap(children: [
          ElevatedButton(
            child: const Text('createRandomCard'),
            onPressed: () {
              String selectedBoxId = context.read<SelectedCardBoxCubit>().selectedCardBoxId;
              context.read<FlashCardRepositoryCubit>().createFlashCardInCardBox(
                  selectedBoxId, new FlashCard('id', 'question', 'solution'));
            },
          ),
          ElevatedButton(
            child: const Text('deleteCards'),
            onPressed: () {
              // context.read<FlashCardRepositoryCubit>().deleteAllCards();
            },
          ),
          ElevatedButton(
            child: const Text('loadRemoteCards'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FetchRemoteCardsScreen(
                      onSave: (fetchUrl) {
                        // context
                        //     .read<FlashCardRepositoryCubit>()
                        //     .importJsonDataFromRemoteUrl(fetchUrl);
                      },
                    ),
                  ));
            },
          ),
        ]),
      ]),
    );
  }

  ListView newDismissibleFlashCardView(context, FlashCardRepositoryState state, String cardBoxId) {
    return ListView.separated(
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items[index];
          return InkWell(
            child: Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item.id),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                context.read<FlashCardRepositoryCubit>().deleteFlashCardInCardBox(cardBoxId, item);
                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Deleted ${item.id}"),
                    action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () => {
                              context
                                  .read<FlashCardRepositoryCubit>()
                                  .createFlashCardInCardBox(cardBoxId, item)
                            }),
                  ),
                );
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: _cardBoxListTile(context, item),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        });
  }

  ListTile _cardBoxListTile(BuildContext context, FlashCard item) {
    return ListTile(
      
      title: Text(
          '${item.id} - Question: ${item.question} - Solution: ${item.solution}'),
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
