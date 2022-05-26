import 'package:oop_lsp/oop_lsp.dart';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageMenu extends StatefulWidget {
  const ManageMenu({Key? key}) : super(key: key);

  @override
  State<ManageMenu> createState() => _ManageMenuState();
}

class _ManageMenuState extends State<ManageMenu> {
  final TextEditingController _searchController = TextEditingController();

  List<Menu> _selectedMenu = [];

  @override
  Widget build(BuildContext context) {
    final MenuProvider menuProvider = context.watch();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Manage Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editor');
                },
                icon: const Icon(CupertinoIcons.add))
          ],
        ),
        const SizedBox(height: 20),
        SearchField(
          controller: _searchController,
          onChanged: (value) async {
            final MenuProvider menuProvider = context.read();
            setState(() {
              _selectedMenu.clear();
            });
            await menuProvider.searchMenu(query: value);
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: menuProvider.menus.length,
                    itemBuilder: (context, index) {
                      final item = menuProvider.menus[index];
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/editor',
                                  arguments: {'item': item});
                            },
                            child: Card(
                              margin: EdgeInsets.zero,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://picsum.photos/200/300/?random',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: context.accentColor,
                                      child: Center(
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Checkbox(
                                value: _selectedMenu.contains(item),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedMenu.contains(item)
                                        ? _selectedMenu.remove(item)
                                        : _selectedMenu.add(item);
                                  });
                                }),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              if (_selectedMenu.isNotEmpty) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 70,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Selected ${_selectedMenu.length}'),
                            Row(
                              children: [
                                IconButton(
                                    icon: const Icon(CupertinoIcons.trash),
                                    onPressed: () async {
                                      final MenuProvider provider =
                                          context.read();
                                      await provider.deleteMenu(_selectedMenu);
                                      setState(() => _selectedMenu.clear());
                                    }),
                                IconButton(
                                  icon: const Icon(CupertinoIcons.xmark),
                                  onPressed: () {
                                    setState(() => _selectedMenu.clear());
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ],
    );
  }
}
