import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    title: Text('GRAFIKA CAFE', style: TextStyle(fontWeight: FontWeight.bold)),
    centerTitle: true,
    elevation: 0,
    actions: <Widget>[
      IconButton(
        icon: Icon(context.isLightMode
            ? CupertinoIcons.moon
            : CupertinoIcons.brightness),
        onPressed: () {
          final ConfigProvider provider = context.read();
          provider.toggleThemeMode();
        },
      ),
      IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () async {
          final bool result = await ConfirmDialog.show(context,
              confirmationMessage: 'Do you want to Sign Out?');
          if (result) {
            final AuthProvider provider = context.read();
            await provider.signOut();
          }
        },
      ),
    ],
    backgroundColor: context.accentColor,
    foregroundColor: context.isLightMode ? Colors.white : Colors.black,
  );
}
