import 'package:acaidajuh/models/product.dart';
import 'package:acaidajuh/screens/edit_product.dart/components/images_form.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product);
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar anúncio'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  debugPrint('Válido');
                } else {
                  debugPrint('Inválido');
                }
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
