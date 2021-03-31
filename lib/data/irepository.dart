/// Repository Interface for CRUD operations
abstract class IRepository<T> {
  // create
  Future<void> create(T object);
  // read
  Future<T> read(dynamic id);
  // update
  Future<void> update(dynamic id, T object);
  // delete
  Future<void> delete(dynamic id);
}
