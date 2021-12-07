import 'package:shopping_list/interfaces/storable.dart';

class Product extends Storable<String> {
  String name;
  String description;
  bool wasAlreadyBought;

  Product(
      {required this.name,
      required this.description,
      this.wasAlreadyBought = false});

  static Product fromJsonMap(Map<String, dynamic> jsonMap) {
    var product = Product(
        name: jsonMap['name'],
        description: jsonMap['description'],
        wasAlreadyBought: jsonMap['wasAlreadyBought']);
    return product;
  }

  @override
  Map<String, dynamic> toJsonMap() {
    var serializedProduct = <String, dynamic>{};

    serializedProduct['name'] = name;
    serializedProduct['description'] = description;
    serializedProduct['wasAlreadyBought'] = wasAlreadyBought;

    return serializedProduct;
  }

  @override
  String getPrimaryKey() {
    return name;
  }
}
