abstract class IDocRepository<T> {
  Future<List<T>> getAll();
  Future<T> getOne(int id);
  Future<void> fetch();
}
