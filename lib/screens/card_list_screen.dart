import 'package:card_learning/blocs/card_list/card_list_cubit.dart';
import 'package:card_learning/blocs/card_list/card_list_state.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'fetch_remote_cards_screen.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.
    context.read<CardListCubit>().fetchCardsFromCurrentBox();

    return Scaffold(
      appBar: AppBar(
        title: Text('Card List View'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: BlocBuilder<CardListCubit, CardListState>(
            builder: (context, state) {
              switch (state.status) {
                case FlashCardRepositoryStatus.loading:
                  return Center(child: CircularProgressIndicator());
                case FlashCardRepositoryStatus.failure:
                  return Center(child: Text('Something is wrong'));
                case FlashCardRepositoryStatus.success:
                  if (state.items.isEmpty) {
                    return Center(child: Text('No flashCards'));
                  }
                  return _tableView(context, state);
                default:
                  return Column(children: [
                    Center(child: CircularProgressIndicator()),
                    Text('test')
                  ]);
              }
            },
          ),
        ),
        Wrap(children: [
          ElevatedButton(
            child: const Text('createRandomCard'),
            onPressed: () {
              final String randomId = Uuid().v4();
              var faker = Faker();
              final FlashCard newFlashCard = FlashCard(
                  randomId,
                  faker.person.firstName(),
                  faker.person.lastName(),
                  DateTime.now());
              context
                  .read<CardListCubit>()
                  .createCardInCurrentBox(newFlashCard);
            },
          ),
          ElevatedButton(
            child: const Text('deleteAllCards'),
            onPressed: () {
              context.read<CardListCubit>().deleteAllCardsInCurrentBox();
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

  Widget _tableView(BuildContext context, CardListState state) {
    List<DataColumn> columns = [
      // DataColumn(label: Text('id')),
      DataColumn(label: Text('questionText')),
      DataColumn(label: Text('solutionText')),
    ];

    List<DataRow> rows = [];
    for (var card in state.items) {
      rows.add(DataRow(cells: [
        // DataCell(Text(card.id)),
        DataCell(Text(card.questionText)),
        DataCell(Text(card.solutionText)),
      ]));
    }

    return SingleChildScrollView(
      child: DataTable(
        columns: columns,
        rows: rows,
      ),
    );
  }

  ListView newDismissibleFlashCardView(
      BuildContext context, CardListState state, String cardBoxId) {
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
              onDismissed: (_) {
                // Remove the item from the data source.
                context.read<CardListCubit>().deleteCardInCurrentBox(item);
                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Deleted ${item.id}"),
                    action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () => {
                              context
                                  .read<CardListCubit>()
                                  .createCardInCurrentBox(item)
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
          '[${item.id.substring(0, 13)}...] - Question: ${item.questionText} - Solution: ${item.solutionText}'),
    );
  }
}
