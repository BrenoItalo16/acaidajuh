import 'package:flutter/material.dart';
import 'package:acaidajuh/common/custom_drawer/custom_drawer.dart';
import 'package:acaidajuh/models/page_manager.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:acaidajuh/screens/admin_users/admin_users_screen.dart';
import 'package:acaidajuh/screens/home/home_screen.dart';
import 'package:acaidajuh/screens/orders/orders_screen.dart';
import 'package:acaidajuh/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

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
              OrdersScreen(),
              ProductsScreen(), //Acesso à tela Produtos
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'), //Acesso à tela Lojas
                ),
              ),
              if (userManager.adminEnabled) ...[
                //Acesso à tela Produtos
                AdminUsersScreen(),
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
