import 'package:acaidajuh/common/custom_drawer/custom_drawer_header.dart';
import 'package:acaidajuh/common/custom_drawer/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 255, 255,
                      255), //* altera a cor de parte de cima do drawer
                  Colors.white10, //* altera a cor de parte de baixo do drawer
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(iconData: Icons.home, title: 'Home', page: 0),
              DrawerTile(iconData: Icons.list, title: 'Meus Pedidos', page: 1),
              DrawerTile(iconData: Icons.list, title: 'Produtos', page: 2),
              DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3),
            ],
          ),
        ],
      ),
    );
  }
}
