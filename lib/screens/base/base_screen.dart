import 'package:acaidajuh/common/custom_drawer/custom_drawer.dart';
import 'package:acaidajuh/models/page_manager.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:acaidajuh/screens/admin_users/admin_users_screen.dart';
import 'package:acaidajuh/screens/home/home_screen.dart';
//import 'package:acaidajuh/screens/login/login_screen.dart';
import 'package:acaidajuh/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  //final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title:
                      const Text('Meus Pedidos'), //Acesso à tela Meus Pedidos
                ),
              ),
              ProductsScreen(), //Acesso à tela Produtos
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'), //Acesso à tela Lojas
                ),
              ),
              if (userManager.adminEnabled) ...[
                //Acesso à tela Produtos
                AdminUsersScree(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ), //Acesso à tela Lojas
              ], //Acesso à tela Produtos
            ],
          );
        },
      ),
    );
  }
}
