import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartDetail extends StatefulWidget {
  final void Function() onBack;

  const CartDetail({Key? key, required this.onBack}) : super(key: key);

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  widget.onBack();
                },
                icon: Icon(Icons.arrow_back))
          ],
        ),
        Expanded(child: Text('Test'))
      ],
    ));
  }
}
