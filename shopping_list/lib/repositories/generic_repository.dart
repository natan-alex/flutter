import 'package:shopping_list/interfaces/storable.dart';

class GenericRepository<TModel extends Storable<TKey>, TKey> {
  final List<TModel> _items = List.empty(growable: true);

  showItems() {
    for (TModel item in _items) {
      print(item.toJsonMap().toString());
    }
  }

  void addItem(TModel newItem) {
    _items.add(newItem);
  }

  TModel getItemById(TKey id) {
    return _items.firstWhere((element) => element.getPrimaryKey() == id);
  }

  List<TModel> getAllItems() {
    return _items;
  }

  void deleteItemById(TKey id) {
    _items.removeWhere((element) => element.getPrimaryKey() == id);
  }

  bool updateItem(TModel updatedItem) {
    int itemIndex = _items.indexWhere(
        (element) => element.getPrimaryKey() == updatedItem.getPrimaryKey());

    if (itemIndex == -1) {
      return false;
    }

    _items[itemIndex] = updatedItem;

    return true;
  }
}
