import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/controllers/product_controller.dart';
import 'package:shopping_list/models/product.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProductController>(context);

    return Column(children: [
      AppBar(
        title: const Text(
          "Produtos:",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      Observer(
          builder: (_) => controller.products.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  itemBuilder: (_, index) => getExpansionTileWithProductInfos(
                      controller.products[index], controller))
              : const Padding(
                  child: Text('Não há nenhum produto para ser exibido'),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ))
    ]);
  }

  getExpansionTileWithProductInfos(
      Product product, ProductController controller) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nome do produto: '),
                    Text(product.name),
                  ])),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Descrição do produto: '),
                    Text(product.description)
                  ])),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Produto já comprado? '),
                    Checkbox(
                        value: product.wasAlreadyBought,
                        onChanged: (value) {
                          if (value != null) {
                            product.wasAlreadyBought = value;
                            controller.updateProduct(product);
                          }
                        })
                  ]))
        ]));
  }
}
