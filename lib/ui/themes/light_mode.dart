import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme(BuildContext context) => ThemeData(
      primaryColor: context.accentColor,
      primaryColorDark: context.accentColor,
      inputDecorationTheme: getInputDecorationTheme(context),
      colorScheme: ColorScheme.light(
        secondary: context.accentColor,
      ),
      cardTheme: CardTheme(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black.withOpacity(0.5),
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
          primary: context.accentColor,
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        button: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
            color: Colors.white),
      ),
      iconTheme: IconThemeData(
        color: context.accentColor,
      ),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: context.accentColor),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: context.accentColor,
      ),
    );
