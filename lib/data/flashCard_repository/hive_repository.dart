import 'package:card_learning/exceptions/item_not_existent_exception.dart';
import 'package:hive/hive.dart';

import '../irepository.dart';

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  Future<T> read(dynamic id) async {
    if (this.boxIsClosed) {
      return null;
    }

    return this._box.get(id);
  }

  @override
  Future<void> create(T object) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.add(object);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);

  @override
  Future<void> delete(dynamic id) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.delete(id);
  }

  @override
  Future<void> update(dynamic id, T object) async {
    if (this.boxIsClosed) {
      return;
    }

    try {
      this._box.put(id, object);
    } catch (e) {
      throw new ItemNotExistentException();
    }
  }
}
