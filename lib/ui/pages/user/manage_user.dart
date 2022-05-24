import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oop_lsp/oop_lsp.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({Key? key}) : super(key: key);

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  final TextEditingController _searchController = TextEditingController();

  List<UserProfile> _selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage User',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        SearchField(
          controller: _searchController,
          onChanged: (value) async {
            final UserProvider userProvider = context.read();
            setState(() {
              _selectedUsers.clear();
            });
            await userProvider.searchUser(query: value);
          },
        ),
        SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.7),
                    1: FlexColumnWidth(3.0),
                    2: FlexColumnWidth(1.0),
                    3: FlexColumnWidth(1.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Checkbox(
                              activeColor: context.accentColor,
                              value: _selectedUsers.length ==
                                  userProvider.users.length,
                              onChanged: (value) {
                                setState(() {
                                  _selectedUsers =
                                      value! ? userProvider.users : [];
                                });
                              },
                            ),
                          ),
                        ),
                        const TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Email',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Role',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Action',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                    ]),
                    ...userProvider.users.map(
                      (user) {
                        return TableRow(
                          children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Checkbox(
                                  activeColor: context.accentColor,
                                  value: _selectedUsers.contains(user),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedUsers.add(user);
                                      } else {
                                        _selectedUsers.remove(user);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(user.email),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(user.role),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigator.pushNamed(context, '/edit-user',
                                //     arguments: user);
                              },
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
              if (_selectedUsers.isNotEmpty) ...[
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
                            Text('Selected ${_selectedUsers.length}'),
                            Row(
                              children: [
                                IconButton(
                                    icon: const Icon(CupertinoIcons.trash),
                                    onPressed: () async {
                                      final UserProvider provider =
                                          context.read();
                                      await provider
                                          .deleteUsers(_selectedUsers);
                                      setState(() => _selectedUsers.clear());
                                    }),
                                IconButton(
                                  icon: const Icon(CupertinoIcons.xmark),
                                  onPressed: () {
                                    setState(() => _selectedUsers.clear());
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
