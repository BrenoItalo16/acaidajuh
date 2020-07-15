import 'package:flutter/material.dart';
import 'package:acaidajuh/models/item_size.dart';
import 'package:acaidajuh/models/product.dart';
import 'package:acaidajuh/screens/edit_product.dart/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state) {
        return Column(
          children: state.value.map((size) {
            return EditItemSize(
              size: size,
            );
          }).toList(),
        );
      },
    );
  }
}
