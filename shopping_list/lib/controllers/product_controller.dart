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

  final GenericRepository<Product, int> _repository =
      GenericRepository<Product, int>();

  AbstractProductController() {
    _products = ObservableList.of(_repository.getAllItems());
  }

  Product getProductById(int productId) {
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
  void deleteProduct(int productId) {
    _repository.deleteItemById(productId);
    _products = ObservableList.of(_repository.getAllItems());
  }
}
