import 'package:acaidajuh/common/custom_drawer/custom_drawer_header.dart';
import 'package:acaidajuh/common/custom_drawer/drawer_tile.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              DrawerTile(
                  iconData: Icons.format_list_numbered_rtl,
                  title: 'Meus Pedidos',
                  page: 1),
              DrawerTile(iconData: Icons.list, title: 'Produtos', page: 2),
              DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      children: <Widget>[
                        const Divider(),
                        DrawerTile(
                            iconData: Icons.settings,
                            title: 'Usuários',
                            page: 4),
                        DrawerTile(
                            iconData: Icons.settings_applications,
                            title: 'Pedidos',
                            page: 5),
                        const Divider(),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
