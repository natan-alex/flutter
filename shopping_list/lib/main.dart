import 'package:flutter/material.dart';
import 'package:shopping_list/repositories/generic_repository.dart';

import 'models/product.dart';

void main() {
  test();

  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(title: const Text('List de compras')), body: Column()),
    debugShowCheckedModeBanner: false,
  ));
}

void test() {
  var product = Product(name: 'test', description: 'test test');
  product.id = 1;
  var product2 = Product(name: 't', description: 't');
  product2.id = 2;
  var genericRepo = GenericRepository<Product, int>();
  genericRepo.addItem(product);
  genericRepo.addItem(product2);
  genericRepo.showItems();
  genericRepo.removeItemById(product2.id);
  genericRepo.showItems();
  var updatedProduct = Product(name: 'name', description: 'description');
  updatedProduct.id = product.id;
  genericRepo.updateItem(updatedProduct);
  genericRepo.showItems();
  print(genericRepo.getItemById(product.id).toJsonMap().toString());
}
