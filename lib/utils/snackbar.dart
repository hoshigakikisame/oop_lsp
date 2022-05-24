import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

SnackBar snackbar(BuildContext context,
    {required Widget child, double width = 500, Color? backgroundColor}) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? context.accentColor,
      content: child);
}
