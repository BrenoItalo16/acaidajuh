import 'package:acaidajuh/common/custom_drawer/price_card.dart';
import 'package:acaidajuh/models/cart_manager.dart';
import 'package:acaidajuh/screens/address/components/address_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return PriceCard(
                buttonText: 'Continuar para o pagamento',
                onPressed: cartManager.isAddressValid ? () {} : null,
              );
            },
          )
        ],
      ),
    );
  }
}
