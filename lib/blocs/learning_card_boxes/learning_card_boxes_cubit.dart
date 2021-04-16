import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/learning_card_box.dart';

import 'learning_card_boxes_state.dart';

class LearningCardBoxesCubit extends Cubit<LearningCardBoxesState> {
  final Database _db;

  LearningCardBoxesCubit(this._db) : super(const LearningCardBoxesState.loading());

  final List<LearningCardBox> _learningCardBoxes = [];

  Future<void> fetchList() async {
    try {
      final items = this._learningCardBoxes;
      emit(LearningCardBoxesState.success(items));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }

  Future<void> createLearningCardBox(LearningCardBox learningCardBox) async {
    if (_db.read(learningCardBox.id) == null) {
      throw new Error();
    }

    try {
      // TODO: implement create
      final items = this._learningCardBoxes;
      emit(LearningCardBoxesState.success(items));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }
}
