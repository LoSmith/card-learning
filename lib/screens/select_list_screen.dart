import 'dart:math';

import 'package:card_learning/blocs/learning_card_boxes/learning_card_boxes_cubit.dart';
import 'package:card_learning/blocs/learning_card_boxes/learning_card_boxes_state.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CardListSelection'),
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: _CardList(context),
        ),
        Wrap(children: [
          ElevatedButton(
            child: const Text('create random box'),
            onPressed: () {
              var randomId = Random().nextDouble().toString();
              context
                  .read<LearningCardBoxesCubit>()
                  .createCardBox(LearningCardBox(randomId.toString(), []));
            },
          ),
          ElevatedButton(
            child: const Text('updateList'),
            onPressed: () {
              var randomId = Random().nextDouble().toString();
              var firstItem = context.read<LearningCardBoxesCubit>().state.items.first;
              FlashCard tmp = new FlashCard('id', randomId.toString(), 'solution');
              context
                  .read<LearningCardBoxesCubit>()
                  .updateCardBox(firstItem.id, LearningCardBox(firstItem.id, [tmp, tmp]));
            },
          ),
          ElevatedButton(
            child: const Text('delete first box'),
            onPressed: () {
              var firstItem = context.read<LearningCardBoxesCubit>().state.items.first;
              context.read<LearningCardBoxesCubit>().deleteCardBox(firstItem.id);
            },
          ),
          ElevatedButton(
            child: const Text('deleteAllBoxes'),
            onPressed: () {
              context.read<LearningCardBoxesCubit>().deleteAllCardBoxes();
            },
          ),
        ]),
      ]),
    );
  }

  Widget _CardList(BuildContext context) {
    return BlocBuilder<LearningCardBoxesCubit, LearningCardBoxesState>(
      builder: (context, state) {
        switch (state.status) {
          case LearningCardBoxesStatus.loading:
            return Center(child: CircularProgressIndicator());
            break;

          case LearningCardBoxesStatus.hasNetworkError:
            return Text('Network error');
            break;

          case LearningCardBoxesStatus.success:
            if (state.items?.isEmpty ?? true) {
              return Text('no card boxes');
            }
            return _flashCardListView(state);
            break;

          default:
            return Column(children: [Center(child: CircularProgressIndicator()), Text('test')]);
        }
      },
    );
  }

  ListView _flashCardListView(LearningCardBoxesState state) {
    return ListView(
      children: [
        for (final LearningCardBox learningCardBox in state.items)
          Column(
            children: [
              Text(
                learningCardBox.id,
                textAlign: TextAlign.center,
              ),
              Text(
                'elements in box:' + learningCardBox.cards.length.toString(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        Spacer(),
      ],
    );
  }
}
