import 'package:acaidajuh/models/user_manager.dart';
import 'package:acaidajuh/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:acaidajuh/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Açaí da Juh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 170, 0, 255), //Cor principal
          scaffoldBackgroundColor: const Color.fromARGB(255, 170, 0, 255), //Cor de fundo
          appBarTheme: const AppBarTheme(
            elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/signup':
            return MaterialPageRoute(
              builder: (_) => SignUpScreen()
            );
            default:
            return MaterialPageRoute(
              builder: (_) => BaseScreen()
            );
          }
        },
      )
    );
  }
}
