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
  late DatabaseConfig _cfg;

  Future<void> init(DatabaseConfig config) async {
    this._cfg = config;

    await Hive.initFlutter();
    Hive.registerAdapter(LearningCardBoxAdapter());
    Hive.registerAdapter(FlashCardAdapter());
  }

  Future<List<LearningCardBox>> values() async {
    final box = await Hive.openBox(_boxName);
    return List<LearningCardBox>.from(box.values.toList());
  }

  Future<List<String>> keys() async {
    final box = await Hive.openBox(_boxName);
    return List<String>.from(box.keys.toList());
  }

  Future<void> create(String id, LearningCardBox learningCardBox) async {
    log('create:' + learningCardBox.id.toString());
    this._trySaveItem(id, learningCardBox);
  }

  Future<LearningCardBox> read(String id) async {
    final box = await Hive.openBox(_boxName);
    final LearningCardBox cardBox = box.get(id)!;
    return cardBox;
  }

  Future<void> update(String id, LearningCardBox learningCardBox) async {
    await this._trySaveItem(id, learningCardBox);
  }

  Future<void> delete(dynamic id) async {
    final box = await Hive.openBox(_boxName);
    await box.delete(id);
  }

  Future<void> _trySaveItem(String id, LearningCardBox learningCardBox) async {
    log('_trySaveCardBox:' + id.toString());
    try {
      if (learningCardBox.id.length < 1) {
        throw new Error();
      }
      try {
        final box = await Hive.openBox(_boxName);
        box.put(id, learningCardBox);
        log('_trySaveCardBox:' + id.toString());
      } on Exception {
        log('_trySaveCardBox:' + id.toString() + " element does not exist, creating new element");
      }
    } catch (e) {
      log('Trying to run: "_trySaveCardBox", but something went wrong.');
      throw (e);
    }
  }

  void log(String string) {
    // ignore: unnecessary_statements
    this._cfg.printCRUDActions ? print("database." + string) : null;
  }
}
