import 'package:card_learning/blocs/card_list/card_list_cubit.dart';
import 'package:card_learning/blocs/card_list/card_list_state.dart';
import 'package:card_learning/keys.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/widgets/verification_dialog.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'add_edit_screen.dart';
import 'fetch_remote_cards_screen.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  static const List<String> settingsItems = <String>[
    Keys.Settings,
    Keys.LoadRemote,
    Keys.DeleteAll
  ];

  @override
  Widget build(BuildContext context) {
    context.read<CardListCubit>().fetchCardsFromCurrentBox();

    return Scaffold(
      appBar: AppBar(
        title: Text('Card List View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create random card',
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
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return settingsItems.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
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
      ]),
    );
  }

  void choiceAction(String choice) async {
    if (choice == Keys.Settings) {
      print('Settings');
    } else if (choice == Keys.LoadRemote) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FetchRemoteCardsScreen(
              onSave: (fetchUrl) {
                context.read<CardListCubit>().fetchAndAddCardsFromRemoteUrl(fetchUrl);
              },
            ),
          ));
    } else if (choice == Keys.DeleteAll) {
      Function deleteAllCardsAction = () async =>
          {await context.read<CardListCubit>().deleteAllCardsInCurrentBox()};
      await verifyActionWithPopUpDialog(context, deleteAllCardsAction,
          'Do you want to delete all cards?', 'This action cant be undone.');
    }
  }

  Widget _tableView(BuildContext context, CardListState state) {
    return ListView.builder(
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items[index];
          return InkWell(
            child: Dismissible(
              onDismissed: (direction) {
                context.read<CardListCubit>().deleteCardInCurrentBox(item);
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
              key: Key(item.id),
              background: Container(color: Colors.red),
              child: ListTile(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditScreen(
                          isEditing: true,
                          flashCard: item,
                          onSave: (FlashCard editedCard) {
                            context
                                .read<CardListCubit>()
                                .editCardInCurrentBox(editedCard);
                          },
                        ),
                      ))
                },
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/box.png'),
                  child: Text(item.sortNumber.toString()),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('question: ${item.questionText}'),
                    const SizedBox(height: 4),
                    Text('solution: ${item.solutionText}'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
