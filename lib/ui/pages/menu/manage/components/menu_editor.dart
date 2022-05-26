import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuEditor extends StatefulWidget {
  final Menu? menu;

  const MenuEditor({Key? key, this.menu}) : super(key: key);

  @override
  State<MenuEditor> createState() => _MenuEditorState();
}

class _MenuEditorState extends State<MenuEditor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  initState() {
    _nameController.text = widget.menu?.name ?? '';
    _descriptionController.text = widget.menu?.description ?? '';
    _priceController.text = widget.menu?.price.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Text(
            widget.menu == null ? 'Create New Menu' : 'Update Menu',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
      Expanded(child: buildEditor())
    ]);
  }

  Widget buildEditor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Image rounded
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://picsum.photos/200/300/?random',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(CupertinoIcons.square),
            labelText: 'Name',
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            prefixIcon: Icon(CupertinoIcons.square),
            labelText: 'Description',
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Price',
              prefixIcon: Icon(CupertinoIcons.money_dollar),
            )),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final String name = _nameController.text;
                final String description = _descriptionController.text;
                final String price = _priceController.text;

                final MenuProvider menuProvider = context.read();

                if (name.isNotEmpty &&
                    description.isNotEmpty &&
                    price.isNotEmpty) {
                  if (widget.menu == null) {
                    Menu menu = Menu(
                        name: name,
                        description: description,
                        price: int.parse(price));
                    await menuProvider.createMenu(menu);
                    return;
                  }
                  widget.menu!.name = name;
                  widget.menu!.description = description;
                  widget.menu!.price = int.parse(price);

                  // await menuProvider.updateUser(widget.menu!);
                }
              },
              child: Row(
                children: const [Text('Save')],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
