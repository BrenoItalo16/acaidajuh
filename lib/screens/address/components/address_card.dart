import 'package:acaidajuh/models/address.dart';
import 'package:acaidajuh/screens/address/components/address_input_field.dart';
import 'package:flutter/material.dart';
import 'package:acaidajuh/models/cart_manager.dart';
import 'package:acaidajuh/screens/address/components/cep_input_field.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<CartManager>(
          builder: (_, cartManager, __) {
            final address = cartManager.address ?? Address();

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Endereço de Entrega',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  CepInputField(
                      address), //! Esse texto é exatamente igual ao de baixo
                  AddressInputField(
                      address), //! então um dos dois está errado (Eu acho)
                  if (address.zipCode != null &&
                      cartManager.deliveryPrice != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${address.street}, ${address.number}\n${address.district}\n'
                        '${address.city} - ${address.state}',
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
