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
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<LearningCardBoxesCubit, LearningCardBoxesState>(
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
                  return Column(
                      children: [Center(child: CircularProgressIndicator()), Text('test')]);
              }
            },
          ),
        ),
        Wrap(children: [
          ElevatedButton(
            child: const Text('create new box'),
            onPressed: () {
              context
                  .read<LearningCardBoxesCubit>()
                  .createCardBox(LearningCardBox('spanish_english', []));
            },
          ),
          ElevatedButton(
            child: const Text('updateList'),
            onPressed: () {
              FlashCard tmp = new FlashCard('id', 'question', 'solution');
              context
                  .read<LearningCardBoxesCubit>()
                  .updateCardBox('bla', LearningCardBox('spanish_english2', [tmp, tmp]));
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

  ListView _flashCardListView(LearningCardBoxesState state) {
    return ListView(
      children: [
        Text(state.items.length.toString()),
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
