import 'package:flutter/material.dart';

class AppColors {
  static Color get colorPrimary => const Color.fromRGBO(34, 32, 42, 1);
  static Color get colorSecondary => const Color.fromRGBO(46, 48, 58, 1);

  static const Color appGreen = Color(0xFF54A28F);
  static const Color appYellow = Color(0xFFE7DD8B);
  static const Color green = Color(0xFF4CAF50);
  static const Color colorWhite = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Outros tons, gradientes, etc, você pode criar aqui
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [appGreen, appYellow],
  );
}
