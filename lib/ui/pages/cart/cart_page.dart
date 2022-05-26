import 'package:oop_lsp/oop_lsp.dart';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TransactionState { root, checkout }

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Cart> _selectedCart = [];

  int activePage = 0;

  TransactionState transactionStateFromString(String value) {
    switch (value) {
      case '/':
        return TransactionState.root;
      case '/checkout':
        return TransactionState.checkout;
      default:
        return TransactionState.root;
    }
  }

  Widget buildManageUserPage(Cart cart) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            transactionStateFromString(settings.name!);
          });
        });
        final args = settings.arguments as Map<String, dynamic>?;
        final routes = {
          '/': (context) => CartDetail(
                onBack: () {
                  setState(() {
                    activePage = 0;
                  });
                },
              ),
          '/editor': (context) => Checkout(),
        };

        return MaterialPageRoute(
            settings: settings,
            builder: (context) => routes[settings.name]!(context));
      },
    );
  }

  Widget buildPages() {
    final CartProvider cartProvider = context.watch();
    return IndexedStack(
      index: activePage,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Carts',
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
                final CartProvider cartProvider = context.read();
                setState(() {
                  _selectedCart.clear();
                });
                await cartProvider.searchCart(query: value);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: cartProvider.carts.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.carts[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    activePage = index + 1;
                                  });
                                },
                                child: Card(
                                    margin: EdgeInsets.zero,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('ID : ${item.id.toString()}'),
                                          Text('${item.customerName}'),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Icon(CupertinoIcons.cart),
                                        ],
                                      ),
                                    )),
                              ),
                              Container(
                                child: Checkbox(
                                    value: _selectedCart.contains(item),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedCart.contains(item)
                                            ? _selectedCart.remove(item)
                                            : _selectedCart.add(item);
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
                  if (_selectedCart.isNotEmpty) ...[
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
                                Text('Selected ${_selectedCart.length}'),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(CupertinoIcons.trash),
                                        onPressed: () async {
                                          final CartProvider provider =
                                              context.read();
                                          // await provider.deleteMenu(_selectedCart);
                                          setState(() => _selectedCart.clear());
                                        }),
                                    IconButton(
                                      icon: const Icon(CupertinoIcons.xmark),
                                      onPressed: () {
                                        setState(() => _selectedCart.clear());
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
        ),
        ...cartProvider.carts.map((e) {
          return buildManageUserPage(e);
        }).toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = context.watch();
    return buildPages();
  }
}
