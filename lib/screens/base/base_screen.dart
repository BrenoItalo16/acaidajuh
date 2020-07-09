import 'package:acaidajuh/common/custom_drawer/custom_drawer.dart';
import 'package:acaidajuh/models/page_manager.dart';
import 'package:acaidajuh/screens/home/home_screen.dart';
// import 'package:acaidajuh/screens/login/login_screen.dart';
import 'package:acaidajuh/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final PageController pageController = PageController();

class BaseScreen extends StatelessWidget {
  @override
  final pageController = PageController();
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Meus Pedidos'), //Acesso à tela Meus Pedidos
            ),
          ),
          ProductsScreen(), //Acesso à tela Produtos
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Lojas'), //Acesso à tela Lojas
            ),
          ),
        ],
      ),
    );
  }
}
