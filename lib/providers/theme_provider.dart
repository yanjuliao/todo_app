// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  Color get primaryColor => _isDarkMode
      ? Color.fromRGBO(212, 147, 25, 1)
      : Color.fromARGB(255, 212, 147, 25);
  Color get scaffoldBackgroundColor =>
      _isDarkMode ? Colors.grey[800]! : Color.fromARGB(255, 238, 223, 201);
  Color get appBarColor =>
      _isDarkMode ? Colors.grey[900]! : Color.fromARGB(255, 255, 189, 67);
  Color get textColor => _isDarkMode ? Colors.white : Colors.black;
  Color get checkboxFillColor => _isDarkMode ? Colors.white : Colors.white;
  Color get checkboxCheckColor => _isDarkMode ? Colors.black : Colors.black;
  Color get checkboxActiveColor => _isDarkMode
      ? Color.fromARGB(255, 235, 198, 153)
      : Color.fromARGB(255, 235, 198, 153);
  Color get listItemColor =>
      _isDarkMode ? Colors.grey[700]! : Color.fromARGB(255, 255, 245, 225);
  Color get floatingButtonColor =>
      _isDarkMode ? Colors.grey[900]! : Color.fromARGB(255, 255, 189, 67);
  Color get cardTheme =>
      _isDarkMode ? Colors.grey[900]! : Color.fromARGB(255, 255, 189, 67);
  Color get elevatedButtonColor =>
      _isDarkMode ? Colors.grey[900]! : Color.fromARGB(255, 255, 189, 67);
  Color get elevatedButtonTextColor =>
      _isDarkMode ? Colors.black : Colors.white;

  ThemeData get theme => _isDarkMode
      ? ThemeData.dark().copyWith(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(color: appBarColor),
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyLarge: TextStyle(color: textColor),
                bodyMedium: TextStyle(color: textColor),
                labelLarge: TextStyle(color: elevatedButtonTextColor),
              ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return checkboxFillColor;
            }),
            checkColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return checkboxCheckColor;
            }),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: floatingButtonColor,
          ),
          cardTheme: CardTheme(color: cardTheme),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: elevatedButtonColor,
            ),
          ),
        )
      : ThemeData.light().copyWith(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(color: appBarColor),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: TextStyle(color: textColor),
                bodyMedium: TextStyle(color: textColor),
                labelLarge: TextStyle(color: elevatedButtonTextColor),
              ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return checkboxFillColor;
            }),
            checkColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return checkboxCheckColor;
            }),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: floatingButtonColor,
          ),
          cardTheme: CardTheme(color: cardTheme),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: elevatedButtonColor,
            ),
          ),
        );

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
