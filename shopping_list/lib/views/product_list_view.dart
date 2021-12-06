import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/controllers/product_controller.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProductController>(context);

    return Observer(
        builder: (_) => Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(controller.products[index].name),
                  );
                })));
  }
}
