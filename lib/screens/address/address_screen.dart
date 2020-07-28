import 'package:acaidajuh/screens/address/components/address_card.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
