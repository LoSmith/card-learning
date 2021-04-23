import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/learning_card_box.dart';

import 'card_box_list_state.dart';

class CardBoxListCubit extends Cubit<CardBoxListState> {
  final Database _db;

  CardBoxListCubit(this._db) : super(const CardBoxListState.loading()) {
    this.fetchList();
  }

  List<LearningCardBox> _learningCardBoxes = [];

  Future<void> fetchList() async {
    try {
      this._learningCardBoxes = await this._db.values();
      emit(CardBoxListState.success(this._learningCardBoxes));
    } on Exception {
      emit(const CardBoxListState.failure());
    }
  }

  Future<void> createCardBox(LearningCardBox learningCardBox) async {
    try {
      await this._db.create(learningCardBox.id, learningCardBox);
      await this.fetchList();

      emit(CardBoxListState.success(this._learningCardBoxes));
    } on Exception {
      emit(const CardBoxListState.failure());
    }
  }

  Future<void> updateCardBox(String id, LearningCardBox learningCardBox) async {
    try {
      await this._db.update(id, learningCardBox);
      await this.fetchList();

      emit(CardBoxListState.success(this._learningCardBoxes));
    } on Exception {
      emit(const CardBoxListState.failure());
    }
  }

  Future<void> deleteCardBox(String id) async {
    try {
      var allCardBoxNames = await this._db.keys();
      if (allCardBoxNames.contains(id)) {
        await this._db.delete(id);
      }
      await this.fetchList();
      emit(CardBoxListState.success(this._learningCardBoxes));
    } on Exception {
      emit(const CardBoxListState.failure());
    }
  }

  Future<void> deleteAllCardBoxes() async {
    try {
      var allCardBoxNames = await this._db.keys();
      for (var boxName in allCardBoxNames) {
        await this._db.delete(boxName);
      }
      await this.fetchList();
      emit(CardBoxListState.success(this._learningCardBoxes));
    } on Exception {
      emit(const CardBoxListState.failure());
    }
  }
}
