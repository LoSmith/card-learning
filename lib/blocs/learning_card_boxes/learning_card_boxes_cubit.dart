import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/learning_card_box.dart';

import 'learning_card_boxes_state.dart';

class LearningCardBoxesCubit extends Cubit<LearningCardBoxesState> {
  final Database _db;

  LearningCardBoxesCubit(this._db) : super(const LearningCardBoxesState.loading()) {
    this.fetchList();
  }

  List<LearningCardBox> _learningCardBoxes = [];

  Future<void> fetchList() async {
    try {
      this._learningCardBoxes = this._db.values;
      emit(LearningCardBoxesState.success(this._learningCardBoxes));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }

  Future<void> createCardBox(LearningCardBox learningCardBox) async {
    try {
      await this._db.create(learningCardBox.id, learningCardBox);
      await this.fetchList();

      emit(LearningCardBoxesState.success(this._learningCardBoxes));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }

  Future<void> updateCardBox(String id, LearningCardBox learningCardBox) async {
    try {
      await this._db.update(id, learningCardBox);
      await this.fetchList();

      emit(LearningCardBoxesState.success(this._learningCardBoxes));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }

  Future<void> deleteCardBox(String id) async {
    try {
      var allCardBoxNames = this._db.keys;
      if (allCardBoxNames.contains(id)) {
        await this._db.delete(id);
      }
      await this.fetchList();
      emit(LearningCardBoxesState.success(this._learningCardBoxes));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }

  Future<void> deleteAllCardBoxes() async {
    try {
      var allCardBoxNames = this._db.keys;
      for (var boxName in allCardBoxNames) {
        await this._db.delete(boxName);
      }
      await this.fetchList();
      emit(LearningCardBoxesState.success(this._learningCardBoxes));
    } on Exception {
      emit(const LearningCardBoxesState.failure());
    }
  }
}
