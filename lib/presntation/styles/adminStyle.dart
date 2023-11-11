import 'package:flutter/material.dart';

class AdminStyles {
  // Couleurs
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF5F5F5); // Une teinte de gris clair

  // Textes
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle subHeadingTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  // Boutons
  static ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: secondaryColor, backgroundColor: primaryColor,
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // App Bar
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: primaryColor,
    iconTheme: const IconThemeData(color: secondaryColor), toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
    ).bodyMedium, titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
    ).titleLarge,
  );

  // Containers
  static BoxDecoration containerDecoration = BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3), // Changement de position de l'ombre
      ),
    ],
  );
}
