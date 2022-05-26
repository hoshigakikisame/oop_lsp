import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ManageUserState { root, editor }

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  void initState() {
    final UserProvider userProvider = context.read();
    print(userProvider.users);
    super.initState();
  }

  int _activePage = 0;

  ManageUserState manageUserStateFromString(String value) {
    switch (value) {
      case '/':
        return ManageUserState.root;
      case '/editor':
        return ManageUserState.editor;
      default:
        return ManageUserState.root;
    }
  }

  Widget buildManageUserPage() {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            manageUserStateFromString(settings.name!);
          });
        });
        final args = settings.arguments as Map<String, dynamic>?;
        final routes = {
          '/': (context) => const ManageUser(),
          '/editor': (context) => UserEditor(profile: args?['item']),
        };

        return MaterialPageRoute(
            settings: settings,
            builder: (context) => routes[settings.name]!(context));
      },
    );
  }

  List<Widget> get pages => [
        buildManageUserPage(),
        Container(child: Center(child: Text('Admin'))),
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
