import 'package:credimaster/src/pages/profile/widgets/theme_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsWidget extends StatelessWidget {
  const ProfileSettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ajustes"),
                Icon(
                  FontAwesomeIcons.gears,
                  size: 13,
                )
              ],
            ),
            const Divider(),
            const ThemeListTile(),
            ListTile(
              onTap: () => showAboutDialog(
                  context: context,
                  applicationName: "CrediMaster",
                  applicationVersion: "0.9.9",
                  applicationIcon: Image.asset(
                    "assets/icon/icon.png",
                    height: 60,
                  ),
                  applicationLegalese:
                      "Developed by   Open Solution Systems © 2020"),
              leading: Icon(
                FontAwesomeIcons.info,
                color: Theme.of(context).iconTheme.color,
                size: 30,
              ),
              title: const Text("Acerca de"),
              subtitle: const Text("Conoce mas sobre nosotros"),
            ), 
          ],
        ),
      ),
    );
  }
}
 