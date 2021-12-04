abstract class CRUD<TModel, TId> {
  Future<List<TModel>> getAllItems();
  Future<TModel?> getItemById(TId id);
  Future<bool> updateItem(TId id, TModel newItem);
  Future<bool> deleteItemById(TId id);
  Future createItem(TModel newItem);
}
