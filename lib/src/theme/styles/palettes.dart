import 'package:flutter/material.dart';
// Paletas de colores para aplicar en los temas de la aplicacion

// Creamos una clase abstracta que definira los tipos de colores
abstract class PaletteColors {
  late Color primaryColor;
  late Color primaryColorDark;
  late Color accentColor;
  late Color iconColor;
  late Color backgroundColor;
  late Color appBarColor;
}

class DarkPalette implements PaletteColors {
  @override
  Color accentColor = Colors.green[600]!;

  @override
  Color primaryColor = Colors.green[800]!;

  @override
  Color iconColor = Colors.white;

  @override
  Color backgroundColor = const Color(0xff303030);

  @override
  Color primaryColorDark = const Color(0xff3C953F);

  @override
  Color appBarColor = const Color(0xff212121);
}

class LightPalette implements PaletteColors {
  @override
  Color accentColor = Colors.green[600]!;

  @override
  Color primaryColor = Colors.green;

  @override
  Color iconColor = Colors.green;

  @override
  Color backgroundColor = const Color(0XFFF9FAFF);

  @override
  Color primaryColorDark = const Color(0XFF3C953F);

  @override
  Color appBarColor = Colors.green;
}
