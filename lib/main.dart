import 'package:acaidajuh/models/admin_users_manager.dart';
import 'package:acaidajuh/models/home_manager.dart';
import 'package:acaidajuh/models/product.dart';
import 'package:acaidajuh/models/product_manager.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:acaidajuh/screens/address/address_screen.dart';
import 'package:acaidajuh/screens/cart/cart_screen.dart';
import 'package:acaidajuh/screens/edit_product.dart/edit_product_screen.dart';
import 'package:acaidajuh/screens/login/login_screen.dart';
import 'package:acaidajuh/screens/product/product_screen.dart';
import 'package:acaidajuh/screens/select_product/select_product_screen.dart';
import 'package:acaidajuh/screens/signup/signup_screen.dart';
import 'package:acaidajuh/services/cepaberto_service.dart';
import 'package:flutter/material.dart';
import 'package:acaidajuh/screens/base/base_screen.dart';
import 'package:provider/provider.dart';
import 'models/cart_manager.dart';

void main() {
  runApp(MyApp());

  CepAbertoService()
      .getAddressFromCep('59508000')
      .then((address) => print(address));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        title: 'Açaí da Juh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(
              255, 128, 0, 128), //Cor principal 255, 170, 0, 255
          scaffoldBackgroundColor: const Color.fromARGB(
              255, 128, 0, 128), //Cor de fundo 255, 170, 0, 255
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(
                  settings.arguments as Product,
                ),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartScreen(),
              );
            case '/address':
              return MaterialPageRoute(
                builder: (_) => AddressScreen(),
              );
            case '/select_product':
              return MaterialPageRoute(
                builder: (_) => SelectProductScreen(),
              );
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) => EditProductScreen(
                  settings.arguments as Product,
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
