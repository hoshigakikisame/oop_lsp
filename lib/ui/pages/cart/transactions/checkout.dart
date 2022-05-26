import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  print('dsadas');
                },
                icon: const Icon(Icons.arrow_back))
          ],
        ),
        const Expanded(child: Text('Test'))
      ],
    ));
  }
}
