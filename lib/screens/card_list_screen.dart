import 'package:card_learning/blocs/card_list/card_list_cubit.dart';
import 'package:card_learning/blocs/card_list/card_list_state.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/screens/add_edit_screen.dart';
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
                    builder: (context) =>
                        FetchRemoteCardsScreen(
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
      DataColumn(label: Text('')),
    ];

    List<DataRow> rows = [];
    for (var card in state.items) {
      var editCallback = (card) =>
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddEditScreen(
                    isEditing: true,
                    flashCard: card,
                    onSave: (FlashCard editedCard) {
                      context
                          .read<CardListCubit>()
                          .editCardInCurrentBox(editedCard);
                    },
                  ),
            ))
      };
      var deleteCallback = (card) => {
        context.read<CardListCubit>().deleteCardInCurrentBox(card),
        // Then show a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text("Deleted ${card.id}"),
        action: SnackBarAction(
        label: "UNDO",
        onPressed: () => {context.read<CardListCubit>().createCardInCurrentBox(card)}),
        ),
        )
    };
      rows.add(DataRow(cells: [
        DataCell(Text(card.questionText)),
        DataCell(Text(card.solutionText)),
        DataCell(Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => editCallback(card)),
            IconButton(
                icon: const Icon(Icons.delete), onPressed: () => deleteCallback(card)),
          ],
        )),
      ]));
    }

    return SingleChildScrollView(
      child: DataTable(
        columns: columns,
        rows: rows,
      ),
    );
  }
}
