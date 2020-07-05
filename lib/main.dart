import 'package:acaidajuh/models/product.dart';
import 'package:acaidajuh/models/product_manager.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:acaidajuh/screens/cart/cart_screen.dart';
import 'package:acaidajuh/screens/login/login_screen.dart';
import 'package:acaidajuh/screens/product/product_screen.dart';
import 'package:acaidajuh/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:acaidajuh/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

import 'models/cart_manager.dart';

void main() {
  runApp(MyApp());
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
        Provider(
          create: (_) => CartManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Açaí da Juh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 170, 0, 255), //Cor principal
          scaffoldBackgroundColor:
              const Color.fromARGB(255, 170, 0, 255), //Cor de fundo
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
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
