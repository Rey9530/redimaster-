import 'package:credimaster/src/pages/login/widget/login_header_wiget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:credimaster/src/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvide>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const LoginHeader(),
            Form(
              key: provider.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      controller: provider.userController,
                      validator: (value) =>
                          (value != null && value.trim().isNotEmpty)
                              ? null
                              : "Ingrese un nombre de usuario",
                      decoration: const InputDecoration(labelText: "Usuario"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: provider.passwordController,
                      validator: (value) =>
                          (value != null && value.trim().isNotEmpty)
                              ? null
                              : "Ingrese una contraseña",
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: "Contraseña"),
                    ),
                    const SizedBox(height: 30),
                    provider.loading
                        ? const CircularProgressIndicator()
                        : RoundedButtonWidget(
                            text: "INICIAR SESION",
                            onPressed: () async {
                              if (!provider.formKey.currentState!.validate()) {
                                return;
                              }
                              dynamic resp = await provider.logIn();
                              if (resp == "200") {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  'checking',
                                  (Route<dynamic> route) => false,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: resp,
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
