import 'package:credimaster/src/theme/styles/palettes.dart';
import 'package:flutter/material.dart';

PaletteColors dark = DarkPalette();
PaletteColors light = LightPalette();

final themesData = {
  ThemeMode.light: _createTheme(colors: light, isDark: false),
  ThemeMode.dark: _createTheme(colors: dark, isDark: true),
};

// Funcion que crea un ThemeData a partir de una paleta de colores
ThemeData _createTheme({required PaletteColors colors, required bool isDark}) {
  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    appBarTheme:
        AppBarTheme(elevation: 0, centerTitle: true, color: colors.appBarColor),
    primaryColor: colors.primaryColor,
    primaryColorDark: colors.primaryColorDark,
    colorScheme: isDark
        ? ColorScheme.fromSwatch().copyWith(
            primary: colors.primaryColorDark,
            secondary: colors.accentColor,
            brightness: Brightness.dark,
          )
        : null,
    scaffoldBackgroundColor: colors.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData()
        .copyWith(backgroundColor: colors.primaryColor),
    // Temas para iconos
    iconTheme: IconThemeData(color: colors.iconColor),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colors.accentColor;
          }
          return null;
        },
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colors.accentColor;
          }
          return null;
        },
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colors.accentColor;
          }
          return null;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colors.accentColor;
          }
          return null;
        },
      ),
    ),
  );
}
