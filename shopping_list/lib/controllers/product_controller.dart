import 'package:mobx/mobx.dart';
import 'package:shopping_list/models/product.dart';
import 'package:shopping_list/repositories/generic_repository.dart';

part 'product_controller.g.dart';

class ProductController = AbstractProductController with _$ProductController;

abstract class AbstractProductController with Store {
  @readonly
  late final List<Product> _products;

  late final GenericRepository<Product, int> _repository;

  AbstractProductController() {
    _repository = GenericRepository<Product, int>();
    _products = List.empty(growable: true);
  }

  @action
  List<Product> getAllProducts() {
    _products = _repository.getAllItems();
    return _products;
  }

  @action
  Product getProductById(int productId) {
    return _repository.getItemById(productId);
  }

  @action
  void addNewProduct(Product newProduct) {
    _repository.addItem(newProduct);
  }

  @action
  bool updateProduct(Product updatedProduct) {
    return _repository.updateItem(updatedProduct);
  }

  @action
  void deleteProduct(int productId) {
    _repository.deleteItemById(productId);
  }
}