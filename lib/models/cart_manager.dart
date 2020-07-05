import 'package:acaidajuh/models/cart_product.dart';
import 'package:acaidajuh/models/product.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
  }
}
