import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

ThemeData getDarkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF181818),
      canvasColor: const Color(0xFF181818),
      primaryColorDark: context.accentColor,
      // ignore: deprecated_member_use
      accentColor: context.accentColor,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF181818),
        secondary: context.accentColor,
      ),
      inputDecorationTheme: getInputDecorationTheme(context),
      dialogTheme: const DialogTheme(
        backgroundColor: Color(0xFF181818),
      ),
      cardTheme: CardTheme(
        elevation: 8.0,
        color: const Color(0xFF242424),
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.yellow.withOpacity(0.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onSurface: Colors.white,
          primary: context.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(
            letterSpacing: 1.2,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        button: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      ),
      iconTheme: IconThemeData(
        color: context.accentColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: context.accentColor,
      ),
    );
