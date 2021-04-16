import 'package:card_learning/models/learning_card_box.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  final String _boxName = '__HIVE_REPOSITORY_ID__';
  Box _box;

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
  int get numberOfBoxes => this._box.keys.length;

  Future<Database> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LearningCardBoxAdapter());
    _box = await Hive.openBox<LearningCardBox>(_boxName);
    return this;
  }

  dispose() {
    this._box.close();
  }

  Future<void> create(LearningCardBox learningCardBox) async {
    if (this.boxIsClosed) {
      return;
    }
    if (learningCardBox.id == null || learningCardBox.id.length < 1) {
      return;
    }

    await this._box.put(learningCardBox.id, learningCardBox);
  }

  Future<LearningCardBox> read(String id) async {
    if (this.boxIsClosed) {
      return null;
    }
    var result = this._box.get(id);
    return result;
  }

  Future<void> update(LearningCardBox learningCardBox) async {
    // TODO implement update
  }

  Future<void> delete(dynamic id) async {
    // TODO: implement delete
  }
}
