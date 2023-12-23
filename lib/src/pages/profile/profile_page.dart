// ignore_for_file: use_build_context_synchronously

import 'package:credimaster/src/pages/profile/widgets/profile_settings_widget.dart';
import 'package:credimaster/src/pages/profile/widgets/profile_user_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:credimaster/src/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvide>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuario"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ProfileUserWidget(
                name: provider.userModel?.name ?? "",
                user: provider.userModel?.user ?? "",
                roll: (provider.userModel?.roll == 1)
                    ? "Administrador"
                    : "Cobrador",
              ),
              const ProfileSettingsWidget(),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ListTile(
                    onTap: () async {
                      bool? close = await showDialog<bool>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const ConfirmDialog(title: "¿Cerrar Sesión?");
                        },
                      );

                      if (close != null && close) {
                        await provider.logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          'checking',
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    leading: Icon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: const Text("Cerrar sesión"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
