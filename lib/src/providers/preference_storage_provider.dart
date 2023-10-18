import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferenceStorageProvide extends ChangeNotifier {
  PreferenceStorageProvide() {
    getTheme();
  }
// Create storage
  final storage = const FlutterSecureStorage();
  ThemeMode theme = ThemeMode.light;
  Future<ThemeMode> getTheme() async {
    String value = await storage.read(key: "theme") ?? "";
    theme = value == "dark" ? ThemeMode.dark : ThemeMode.light;
    return value == "dark" ? ThemeMode.dark : ThemeMode.light;
  }

  updateTheme(value) async {
    theme = value == "dark" ? ThemeMode.dark : ThemeMode.light;
    await storage.write(key: "theme", value: value.toString());
    notifyListeners();
  }
}
