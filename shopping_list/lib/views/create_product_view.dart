import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/controllers/product_controller.dart';
import 'package:shopping_list/models/product.dart';

class CreateProductView extends StatefulWidget {
  @override
  _CreateProductViewState createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? nullOrEmptyValidator(String? value, String feedback) {
    if (value == null || value.isEmpty) {
      return feedback;
    }

    return null;
  }

  Padding createPaddingWithTextFormFieldInside(TextEditingController controller,
      String placeholder, String onErrorMessage) {
    return Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: TextFormField(
          decoration: InputDecoration(hintText: placeholder),
          controller: controller,
          validator: (value) {
            nullOrEmptyValidator(value, onErrorMessage);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProductController>(context);

    return Container(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              createPaddingWithTextFormFieldInside(_nameController,
                  'Nome do produto', 'Nome do produto inválido'),
              createPaddingWithTextFormFieldInside(_descriptionController,
                  'Descrição do produto', 'Descrição do produto inválida'),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      controller.addNewProduct(Product(
                          name: _nameController.text,
                          description: _descriptionController.text));
                      _nameController.clear();
                      _descriptionController.clear();
                    }
                  },
                  child: const Text('Adicionar produto'))
            ],
          ),
        ));
  }
}
