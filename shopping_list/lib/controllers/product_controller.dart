import 'package:mobx/mobx.dart';
import 'package:shopping_list/models/product.dart';
import 'package:shopping_list/repositories/generic_repository.dart';

part 'product_controller.g.dart';

class ProductController extends AbstractProductController
    with _$ProductController {
  ProductController() : super();
}

abstract class AbstractProductController with Store {
  @readonly
  ObservableList<Product> _products = ObservableList<Product>();

  final GenericRepository<Product, String> _repository =
      GenericRepository<Product, String>();

  AbstractProductController() {
    _products = ObservableList.of(_repository.getAllItems());
  }

  Product getProductById(String productId) {
    return _repository.getItemById(productId);
  }

  @action
  void addNewProduct(Product newProduct) {
    _repository.addItem(newProduct);
    _products = ObservableList.of(_repository.getAllItems());
  }

  @action
  bool updateProduct(Product updatedProduct) {
    if (_repository.updateItem(updatedProduct)) {
      _products = ObservableList.of(_repository.getAllItems());
      return true;
    }

    return false;
  }

  @action
  void deleteProduct(String productId) {
    _repository.deleteItemById(productId);
    _products = ObservableList.of(_repository.getAllItems());
  }
}
