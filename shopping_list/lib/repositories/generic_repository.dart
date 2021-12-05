import 'package:shopping_list/interfaces/storable.dart';

class GenericRepository<TModel extends Storable<TKey>, TKey> {
  List<TModel> items = List.empty(growable: true);

  showItems() {
    for (TModel item in items) {
      print(item.toJsonMap().toString());
    }
  }

  void addItem(TModel newItem) {
    items.add(newItem);
  }

  TModel getItemById(TKey id) {
    return items.firstWhere((element) => element.getPrimaryKey() == id);
  }

  List<TModel> getAllItems() {
    return items;
  }

  void deleteItemById(TKey id) {
    items.removeWhere((element) => element.getPrimaryKey() == id);
  }

  bool updateItem(TModel updatedItem) {
    int itemIndex = items.indexWhere(
        (element) => element.getPrimaryKey() == updatedItem.getPrimaryKey());

    if (itemIndex == -1) {
      return false;
    }

    items[itemIndex] = updatedItem;

    return true;
  }
}
