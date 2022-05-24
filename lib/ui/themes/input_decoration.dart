import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

InputDecorationTheme getInputDecorationTheme(BuildContext context) =>
    InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFC4C4C4),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1.5,
          color: context.accentColor,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      isDense: true,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      iconColor: context.accentColor,
      counterStyle: TextStyle(
        color: context.accentColor,
      ),
    );
