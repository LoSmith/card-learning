import 'dart:math';
import 'package:card_learning/blocs/card_box_list/card_box_list_cubit.dart';
import 'package:card_learning/blocs/card_box_list/card_box_list_state.dart';
import 'package:card_learning/blocs/selected_card_box/selected_card_box_cubit.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardBoxListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CardListSelection'),
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: _cardBoxList(context),
        ),
        Wrap(children: [
          ElevatedButton(
            child: const Text('create random box'),
            onPressed: () {
              var randomId = Random().nextDouble().toString();
              context
                  .read<CardBoxListCubit>()
                  .createCardBox(LearningCardBox(randomId.toString(), []));
            },
          ),
          ElevatedButton(
            child: const Text('updateList'),
            onPressed: () {
              var randomId = Random().nextDouble().toString();
              var firstItem = context.read<CardBoxListCubit>().state.items.first;
              FlashCard tmp = new FlashCard('id', randomId.toString(), 'solution');
              context
                  .read<CardBoxListCubit>()
                  .updateCardBox(firstItem.id, LearningCardBox(firstItem.id, [tmp, tmp]));
            },
          ),
          ElevatedButton(
            child: const Text('delete first box'),
            onPressed: () {
              var firstItem = context.read<CardBoxListCubit>().state.items.first;
              context.read<CardBoxListCubit>().deleteCardBox(firstItem.id);
            },
          ),
          ElevatedButton(
            child: const Text('deleteAllBoxes'),
            onPressed: () {
              context.read<CardBoxListCubit>().deleteAllCardBoxes();
            },
          ),
        ]),
      ]),
    );
  }

  Widget _cardBoxList(BuildContext context) {
    return BlocBuilder<CardBoxListCubit, CardBoxListState>(
      builder: (context, state) {
        switch (state.status) {
          case CardBoxListStatus.loading:
            return Center(child: CircularProgressIndicator());
            break;

          case CardBoxListStatus.hasNetworkError:
            return Text('Network error');
            break;

          case CardBoxListStatus.success:
            if (state.items?.isEmpty ?? true) {
              return Text('no card boxes');
            }
            return _dismissibleListView(state);
            break;

          default:
            return Column(children: [Center(child: CircularProgressIndicator()), Text('test')]);
        }
      },
    );
  }

  ListView _dismissibleListView(CardBoxListState state) {
    return ListView.separated(
      itemCount: state.items.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        final int cardListTab = 1;
        final item = state.items[index];
        return InkWell(
          onTap: () => {
            context.read<SelectedCardBoxCubit>().setSelectedCardBox(item.id),
            print(context.read<SelectedCardBoxCubit>().selectedCardBoxId),
            DefaultTabController.of(context).animateTo(cardListTab)
          },
          child: Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item.id),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              context.read<CardBoxListCubit>().deleteCardBox(item.id);
              // Then show a snackbar.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Deleted ${item.id}"),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () => {context.read<CardBoxListCubit>().createCardBox(item)}),
                ),
              );
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: _cardBoxListTile(context, item),
          ),
        );
      },
    );
  }
}

ListTile _cardBoxListTile(BuildContext context, LearningCardBox item) {
  return ListTile(title: Text('CardBox: ${item.id} - NoItems: ${item.cards.length}'));
}
