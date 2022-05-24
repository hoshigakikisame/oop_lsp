import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

extension BuildContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  Color get accentColor {
    final ConfigProvider provider = read();
    return provider.accentColor;
  }
}
