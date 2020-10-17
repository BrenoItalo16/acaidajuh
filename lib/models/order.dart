import 'package:acaidajuh/models/address.dart';
import 'package:acaidajuh/models/cart_manager.dart';
import 'package:acaidajuh/models/cart_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  final Firestore firestore = Firestore.instance;
  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userId,
      'address': address.toMap(),
    });
  }

  String orderId;
  List<CartProduct> items;
  num price;
  String userId;
  Address address;
  Timestamp date;
}
