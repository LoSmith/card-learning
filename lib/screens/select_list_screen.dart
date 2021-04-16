import 'package:card_learning/blocs/learning_card_boxes/learning_card_boxes_cubit.dart';
import 'package:card_learning/blocs/learning_card_boxes/learning_card_boxes_state.dart';
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
            child: const Text('pushDummyBox'),
            onPressed: () {
              context
                  .read<LearningCardBoxesCubit>()
                  .createLearningCardBox(LearningCardBox('newId', []));
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
                learningCardBox.cards.length.toString(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        Spacer(),
      ],
    );
  }
}
