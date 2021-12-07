import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/controllers/product_controller.dart';
import 'package:shopping_list/repositories/generic_repository.dart';
import 'package:shopping_list/views/create_product_view.dart';
import 'package:shopping_list/views/product_list_view.dart';

import 'models/product.dart';

void main() {
  test();

  runApp(Provider<ProductController>(
      create: (_) => ProductController(),
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('List de compras')),
            body: SingleChildScrollView(
              child: Column(
                children: [CreateProductView(), ProductListView()],
              ),
            )),
        debugShowCheckedModeBanner: false,
      )));
}

void test() {
  var product = Product(name: 'test', description: 'test test');
  var product2 = Product(name: 't', description: 't');
  var genericRepo = GenericRepository<Product, String>();
  genericRepo.addItem(product);
  genericRepo.addItem(product2);
  genericRepo.showItems();
  genericRepo.deleteItemById(product2.name);
  genericRepo.showItems();
  var updatedProduct = Product(name: 'name', description: 'description');
  genericRepo.updateItem(updatedProduct);
  genericRepo.showItems();
  print(genericRepo.getItemById(product.name).toJsonMap().toString());
  var controller = ProductController();
  controller.addNewProduct(product);
  print(controller.products);
}
