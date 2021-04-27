import 'package:card_learning/blocs/card_box_list/card_box_list_cubit.dart';
import 'package:card_learning/blocs/card_box_list/card_box_list_state.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/services/selected_card_box_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';

class CardBoxListScreen extends StatefulWidget {
  @override
  _CardBoxListScreenState createState() => _CardBoxListScreenState();
}

class _CardBoxListScreenState extends State<CardBoxListScreen> {
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
              final String randomId = Uuid().v4();
              final String randomBoxName = Faker().sport.name().toString();
              context
                  .read<CardBoxListCubit>()
                  .createCardBox(LearningCardBox(randomId.toString(), randomBoxName, []));
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
          case CardBoxListStatus.hasNetworkError:
            return Center(child: Text('Network error'));
          case CardBoxListStatus.failure:
            return Center(child: Text('something went wrong'));
          case CardBoxListStatus.success:
            if (state.items.isEmpty) {
              return Text('no card boxes');
            }
            return _dismissibleListView(context, state);
          default:
            return Column(children: [Center(child: CircularProgressIndicator()), Text('test')]);
        }
      },
    );
  }

  ListView _dismissibleListView(BuildContext context, CardBoxListState state) {
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
            SelectedCardBoxService().setId(item.id),
            setState(() {}),
            DefaultTabController.of(context)?.animateTo(cardListTab)
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
  final isSelectedBox = SelectedCardBoxService().getId() == item.id;
  final selectedTileColor = Colors.redAccent;
  final unselectedTileColor = Colors.white;
  return ListTile(
    leading: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage('assets/images/box.png'),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cards: ${item.name}'),
        const SizedBox(height: 4),
        Text(
          'CardBox: [${item.id.substring(0, 13)}...]',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text('Cards: ${item.cards.length}')
      ],
    ),
    tileColor: isSelectedBox ? selectedTileColor : unselectedTileColor,
  );
}
