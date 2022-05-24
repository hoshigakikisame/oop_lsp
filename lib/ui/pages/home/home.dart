import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  int _activePage = 0;

  List<Widget> pages = [
    Container(child: Center(child: Text('Page 1'))),
    Container(child: Center(child: Text('Page 1'))),
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
              Icons.add,
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
        body: pages[_activePage]
        // Container(
        //   child: Center(
        //     child: ElevatedButton(
        //       onPressed: () async {
        //         final AuthProvider provider = context.read();
        //         await provider.signOut();
        //       },
        //       child: const Text('Signout'),
        //     ),
        //   ),
        // ),
        );
  }
}
