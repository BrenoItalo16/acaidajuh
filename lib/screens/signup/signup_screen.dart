import 'package:acaidajuh/models/user.dart';
import 'package:acaidajuh/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:acaidajuh/helpers/validators.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                //! Editar
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome completo'),
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name.isEmpty)
                          // ignore: curly_braces_in_flow_control_structures
                          return 'Campo obrigatório!';
                        else if (name.trim().split(' ').length <= 1)
                          // ignore: curly_braces_in_flow_control_structures
                          return 'Preencha seu Nome completo!';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email.isEmpty)
                            // ignore: curly_braces_in_flow_control_structures
                            return 'Campo obrigatório!';
                          else if (!emailValid(email)) return 'Email inválido';
                          return null;
                        },
                        onSaved: (email) => user.email = email),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty)
                          // ignore: curly_braces_in_flow_control_structures
                          return 'Campo obrigatório!';
                        else if (pass.length < 6) return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Repitir Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty)
                          // ignore: curly_braces_in_flow_control_structures
                          return 'Campo obrigatório!';
                        else if (pass.length < 6) return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        height: 44,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();

                                    if (user.password != user.confirmPassword) {
                                      scaffoldKey.currentState
                                          .showSnackBar(const SnackBar(
                                        content: Text('Senhas não coincidem!'),
                                        backgroundColor: Colors.red,
                                      ));
                                      return;
                                    }

                                    userManager.signUp(
                                      user: user,
                                      onSuccess: () {
                                        Navigator.of(context).pop();
                                      },
                                      onFail: (e) {
                                        scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Falha ao cadastrar: $e'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                          child: userManager.loading
                              ? //! Esse UserManager começa com "u" minusculo no tutorial
                              const CircularProgressIndicator(
                                  //TODO A animação de loadin fica aqui
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white))
                              : const Text('Criar Conta',
                                  style: TextStyle(fontSize: 18)),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ); //! Indentar
              },
            ),
          ),
        ),
      ),
    );
  }
}
