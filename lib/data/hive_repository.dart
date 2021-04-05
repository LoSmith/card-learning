import 'package:hive/hive.dart';

import 'irepository.dart';

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  bool get boxIsClosed => !(this._box?.isOpen ?? false);

  @override
  Future<T> read(dynamic id) async {
    if (this.boxIsClosed) {
      return null;
    }
    var result = this._box.get(id);
    return result;
  }

  @override
  Future<void> create(T object) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.add(object);
  }

  @override
  Future<void> delete(dynamic id) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.delete(id);
  }

  @override
  Future<void> update(dynamic id, T object) async {
    // TODO implement update
  }
}
