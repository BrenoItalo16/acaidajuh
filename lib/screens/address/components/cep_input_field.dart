import 'package:acaidajuh/common/custom_drawer/custom_icon_button.dart';
import 'package:acaidajuh/models/address.dart';
import 'package:acaidajuh/models/cart_manager.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  CepInputField(this.address);
  final Address address;

  final TextEditingController cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    if (address.zipCode == null)
      // ignore: curly_braces_in_flow_control_structures
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: cepController,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              hintText: '12.345-678',
            ),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep) {
              if (cep.isEmpty)
                // ignore: curly_braces_in_flow_control_structures
                return 'Campo obrigatório';
              else if (cep.length != 10) return 'CEP inválido!';
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              if (Form.of(context).validate()) {
                context.read<CartManager>().getAddress(cepController.text);
              }
            },
            textColor: Colors.white,
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            child: const Text('Buscar CEP'),
          ),
        ],
      );
    else
      // ignore: curly_braces_in_flow_control_structures
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'CEP: ${address.zipCode}',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: primaryColor,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
            ),
          ],
        ),
      );
  }
}
