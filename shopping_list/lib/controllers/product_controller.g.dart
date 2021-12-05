// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductController on AbstractProductController, Store {
  final _$_productsAtom = Atom(name: 'AbstractProductController._products');

  List<Product> get products {
    _$_productsAtom.reportRead();
    return super._products;
  }

  @override
  List<Product> get _products => products;

  @override
  set _products(List<Product> value) {
    _$_productsAtom.reportWrite(value, super._products, () {
      super._products = value;
    });
  }

  final _$AbstractProductControllerActionController =
      ActionController(name: 'AbstractProductController');

  @override
  List<Product> getAllProducts() {
    final _$actionInfo = _$AbstractProductControllerActionController
        .startAction(name: 'AbstractProductController.getAllProducts');
    try {
      return super.getAllProducts();
    } finally {
      _$AbstractProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewProduct(Product newProduct) {
    final _$actionInfo = _$AbstractProductControllerActionController
        .startAction(name: 'AbstractProductController.addNewProduct');
    try {
      return super.addNewProduct(newProduct);
    } finally {
      _$AbstractProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool updateProduct(Product updatedProduct) {
    final _$actionInfo = _$AbstractProductControllerActionController
        .startAction(name: 'AbstractProductController.updateProduct');
    try {
      return super.updateProduct(updatedProduct);
    } finally {
      _$AbstractProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteProduct(int productId) {
    final _$actionInfo = _$AbstractProductControllerActionController
        .startAction(name: 'AbstractProductController.deleteProduct');
    try {
      return super.deleteProduct(productId);
    } finally {
      _$AbstractProductControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
