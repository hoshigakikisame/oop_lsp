import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ManageMenuState { root, editor }

class HomeManager extends StatefulWidget {
  const HomeManager({Key? key}) : super(key: key);

  @override
  State<HomeManager> createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  @override
  void initState() {
    final MenuProvider menuProvider = context.read();
    super.initState();
  }

  int _activePage = 0;

  ManageMenuState manageMenuStateFromString(String value) {
    switch (value) {
      case '/':
        return ManageMenuState.root;
      case '/editor':
        return ManageMenuState.editor;
      default:
        return ManageMenuState.root;
    }
  }

  Widget buildManageUserPage() {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            manageMenuStateFromString(settings.name!);
          });
        });
        final args = settings.arguments as Map<String, dynamic>?;
        final routes = {
          '/': (context) => const ManageMenu(),
          '/editor': (context) => MenuEditor(menu: args?['item']),
        };

        return MaterialPageRoute(
            settings: settings,
            builder: (context) => routes[settings.name]!(context));
      },
    );
  }

  List<Widget> get pages => [
        buildManageUserPage(),
        Container(child: Center(child: Text('Manager'))),
        ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50.0,
          backgroundColor: Colors.transparent,
          color: context.accentColor,
          items: <Widget>[
            Icon(
              _activePage == 0
                  ? CupertinoIcons.person_2_fill
                  : CupertinoIcons.person_2,
              size: 30,
              color: context.isLightMode ? Colors.white : Color(0xFF181818),
            ),
            Icon(
              Icons.list,
              size: 30,
              color: context.isLightMode ? Colors.white : Color(0xFF181818),
            ),
            Icon(
              CupertinoIcons.person,
              size: 30,
              color: context.isLightMode ? Colors.white : Color(0xFF181818),
            ),
          ],
          animationDuration: Duration(milliseconds: 200),
          onTap: (index) {
            setState(() {
              _activePage = index;
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: pages[_activePage],
        ));
  }
}
