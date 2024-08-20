import 'package:flutter/material.dart';
import '../../data/enums/theme_type.dart';

class ThemeService {
  // Color.fromARGB(162, 15, 3, 34),
  //var a = const Color.fromARGB(162, 15, 3, 34);
  //var b = const Color.fromRGBO(15, 3, 34, .7);
  static ThemeData getTheme(ThemeType themeType) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(15, 3, 34, .1),
      100: const Color.fromRGBO(15, 3, 34, .2),
      200: const Color.fromRGBO(15, 3, 34, .3),
      300: const Color.fromRGBO(15, 3, 34, .4),
      400: const Color.fromRGBO(15, 3, 34, .5),
      500: const Color.fromRGBO(15, 3, 34, .6),
      600: const Color.fromRGBO(15, 3, 34, .7),
      700: const Color.fromRGBO(15, 3, 34, .8),
      800: const Color.fromRGBO(15, 3, 34, .9),
      900: const Color.fromRGBO(15, 3, 34, 1),
    };

    MaterialColor customColor = MaterialColor(0xFF61586F, color);
    switch (themeType) {
      case ThemeType.defaultTheme:
        return ThemeData(
          primarySwatch: customColor, //Colors.blue,
          //backgroundColor: const Color.fromARGB(255, 221, 221, 238),
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          secondaryHeaderColor: const Color.fromRGBO(15, 3, 34, .7),
          //errorColor: Colors.red[300],
          //cardColor: const Color.fromARGB(255, 221, 221, 238),
          //cardColor: const Color.fromARGB(255, 240, 239, 242),
          cardColor: Color.fromARGB(255, 255, 255, 255),
          elevatedButtonTheme: _getElevatedButtonThemeData(),
        );

      case ThemeType.darkTheme:
        return ThemeData(
          primarySwatch: Colors.blue,
        );

      case ThemeType.lightTheme:
        return ThemeData(
          primarySwatch: Colors.blue,
        );
      default:
        return ThemeData(
          primarySwatch: Colors.blue,
        );
    }
  }

  static ElevatedButtonThemeData _getElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => const Color(0xFF3b889a)),
          textStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (states) => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white)),
    );
  }
}
