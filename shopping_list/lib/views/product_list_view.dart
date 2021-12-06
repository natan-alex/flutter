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

    return Column(children: [
      PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: AppBar(
            title: const Text(
              "Produtos:",
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
            elevation: 0.0,
          )),
      Observer(
          builder: (_) => controller.products.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  itemBuilder: (_, index) {
                    final currentItem = controller.products[index];

                    return ListTile(
                      title: Text(currentItem.name),
                      subtitle: Text(currentItem.description),
                    );
                  })
              : const Text('Não há nenhum produto para ser exibido'))
    ]);
  }
}
