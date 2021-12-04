import 'package:shopping_list/interfaces/storable.dart';

class Product extends Storable<int> {
  int id = 0;
  String name;
  String description;
  bool wasAlreadyBought;

  Product(
      {required this.name,
      required this.description,
      this.wasAlreadyBought = false});

  @override
  void fromJsonMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    name = jsonMap['name'];
    description = jsonMap['description'];
    wasAlreadyBought = jsonMap['wasAlreadyBought'];
  }

  @override
  Map<String, dynamic> toJsonMap() {
    var serializedProduct = <String, dynamic>{};

    serializedProduct['id'] = id;
    serializedProduct['name'] = name;
    serializedProduct['description'] = description;
    serializedProduct['wasAlreadyBought'] = wasAlreadyBought;

    return serializedProduct;
  }

  @override
  int getPrimaryKey() {
    return id;
  }
}