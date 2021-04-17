import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseConfig {
  bool printCRUDActions;
  DatabaseConfig(this.printCRUDActions);
}

class Database {
  final String _boxName = '__HIVE_REPOSITORY_ID__';
  DatabaseConfig _cfg;
  Box _box;

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
  List<String> get keys => List<String>.from(this._box.keys.toList());
  List<LearningCardBox> get values => List<LearningCardBox>.from(this._box.values.toList());

  Future<Database> init(DatabaseConfig config) async {
    this._cfg = config;

    await Hive.initFlutter();
    Hive.registerAdapter(LearningCardBoxAdapter());
    Hive.registerAdapter(FlashCardAdapter());
    _box = await Hive.openBox<LearningCardBox>(_boxName);

    print(this.keys);
    print(this.values);
    return this;
  }

  dispose() {
    this._box.close();
  }

  Future<void> create(String id, LearningCardBox learningCardBox) async {
    log('create:' + learningCardBox.id.toString());
    this._trySaveItem(id, learningCardBox);
  }

  Future<LearningCardBox> read(String id) async {
    log('read:' + id.toString());
    if (this.boxIsClosed) {
      throw new Error();
    }
    return this._box.get(id);
  }

  Future<void> update(String id, LearningCardBox learningCardBox) async {
    log('update:' + id.toString());
    if (this.boxIsClosed) {
      throw new Error();
    }

    await this._trySaveItem(id, learningCardBox);
  }

  Future<void> delete(dynamic id) async {
    log('delete:' + id.toString());
    if (this.boxIsClosed) {
      throw new Error();
    }
    await this._box.delete(id);
  }

  Future<void> _trySaveItem(String id, LearningCardBox learningCardBox) async {
    log('_trySaveCardBox:' + id.toString());
    try {
      if (this.boxIsClosed) {
        throw new Error();
      }
      if (learningCardBox.id == null || learningCardBox.id.length < 1) {
        throw new Error();
      }
      try {
        var existentItem = await this.read(id);
        if (existentItem != null) {
          this._tryUpdateExistent(id, learningCardBox);
        }
      } on Exception {
        log('_trySaveCardBox:' + id.toString() + " element does not exist, creating new element");
      }

      this._trySaveNew(id, learningCardBox);
    } catch (e) {
      log('Trying to run: "_trySaveCardBox", but something went wrong.');
      throw (e);
    }
  }

  Future<void> _trySaveNew(String id, LearningCardBox item) async {
    log('_trySaveNew:' + id.toString());
    try {
      this._box.put(id, item);
    } catch (e) {
      print('failed to create new item: ' + id);
    }
  }

  Future<void> _tryUpdateExistent(String id, LearningCardBox item) async {
    log('_tryUpdateExistent:' + id.toString());
    try {
      this._box.put(id, item);
    } catch (e) {
      print('failed to update item: ' + id);
    }
  }

  void log(String string) {
    // ignore: unnecessary_statements
    this._cfg.printCRUDActions ? print("database." + string) : null;
  }
}
