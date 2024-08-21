import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/enums/theme_type.dart';

//https://coolors.co/3c899b-49111c-f2f4f3-a9927d-5e503f
class ThemeService {
  static ThemeData getTheme(ThemeType themeType) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(60, 137, 155, .1),
      100: const Color.fromRGBO(60, 137, 155, .2),
      200: const Color.fromRGBO(60, 137, 155, .3),
      300: const Color.fromRGBO(60, 137, 155, .4),
      400: const Color.fromRGBO(60, 137, 155, .5),
      500: const Color.fromRGBO(60, 137, 155, .6),
      600: const Color.fromRGBO(60, 137, 155, .7),
      700: const Color.fromRGBO(60, 137, 155, .8),
      800: const Color.fromRGBO(60, 137, 155, .9),
      900: const Color.fromRGBO(60, 137, 155, 1),
    };

    MaterialColor customColor = MaterialColor(0xFF3c899b, color);
    switch (themeType) {
      case ThemeType.defaultTheme:
        return ThemeData(
          primarySwatch: customColor,
          primaryColor: customColor,
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          secondaryHeaderColor: const Color(0xFF416a6d),
          cardColor: Colors.white,
          cardTheme: _getCardTheme(),
          hintColor: customColor[700],
          focusColor: customColor[900],
          disabledColor: customColor[200],
          highlightColor: customColor[900],
          elevatedButtonTheme: _getElevatedButtonThemeData(),
          buttonTheme: _buildButtonData(),
        );

      case ThemeType.darkTheme:
        return ThemeData(
          primarySwatch: customColor,
          primaryColor: customColor,
        );

      case ThemeType.lightTheme:
        return ThemeData(
          primarySwatch: customColor,
          primaryColor: customColor,
        );
      default:
        return ThemeData(
          primarySwatch: customColor,
          primaryColor: customColor,
        );
    }
  }

  static ElevatedButtonThemeData _getElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => const Color(0xFF3b889a)),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white),
      ),
    );
  }

  static CardTheme _getCardTheme() {
    return const CardTheme(
      color: Color(0xFF9cc5d3),
      elevation: 5,
      shadowColor: Color(0xFF3b889a),
    );
  }

  static ButtonThemeData _buildButtonData() {
    return const ButtonThemeData(buttonColor: Color(0xFF3b889a));
  }
}
