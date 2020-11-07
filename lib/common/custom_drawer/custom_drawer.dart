import 'package:acaidajuh/common/custom_drawer/custom_drawer_header.dart';
import 'package:acaidajuh/common/custom_drawer/drawer_tile.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:footer/footer.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255,
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
              const DrawerTile(iconData: Icons.home, title: 'Início', page: 0),
              const DrawerTile(
                  iconData: Icons.list, title: 'Produtos', page: 1),
              const DrawerTile(
                  iconData: Icons.playlist_add_check,
                  title: 'Meus Pedidos',
                  page: 2),
              const DrawerTile(
                  iconData: Icons.location_on, title: 'Lojas', page: 3),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      children: const <Widget>[
                        Divider(),
                        DrawerTile(
                            iconData: Icons.settings,
                            title: 'Usuários',
                            page: 4),
                        DrawerTile(
                            iconData: Icons.settings_applications,
                            title: 'Pedidos',
                            page: 5),
                        Divider(),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              //todo: inserir o footer
            ],
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'V.0.1 - Desenvolvido por:',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ),
              Footer(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'android/assets/images/devbitt.png',
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
