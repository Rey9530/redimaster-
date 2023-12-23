import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferenceStorageProvide>(context);
    return ListTile(
      leading: FaIcon(
        FontAwesomeIcons.palette,
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text('Tema'),
      subtitle: Text(_showThemeName(provider.theme.toString())),
      trailing: const FaIcon(
        FontAwesomeIcons.chevronRight,
      ),
      onTap: () => Alert(
          content: Column(
            children: [
              const Text("Seleccione un tema"),
              RadioListTile(
                onChanged: (theme) {
                  provider.updateTheme('light');
                  Navigator.pop(context);
                },
                value: ThemeMode.light,
                groupValue: provider.theme,
                title: Text(_showThemeName(ThemeMode.light.toString())),
              ),
              RadioListTile(
                onChanged: (theme) {
                  provider.updateTheme('dark');
                  Navigator.pop(context);
                },
                value: ThemeMode.dark,
                groupValue: provider.theme,
                title: Text(_showThemeName(ThemeMode.dark.toString())),
              ),
            ],
          ),
          context: context,
          buttons: [
            DialogButton(
              color: Colors.grey,
              child: const Text(
                "CANCELAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ]).show(),
    );
  }
}

String _showThemeName(String name) {
  switch (name) {
    case "ThemeMode.light":
      return "Claro";
    default:
      return "Oscuro";
  }
}
