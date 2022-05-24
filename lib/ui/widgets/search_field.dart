import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Future<void> Function(String)? onChanged;

  const SearchField(
      {Key? key, required this.controller, this.focusNode, this.onChanged})
      : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool loadingSearch = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: (value) async {
        if (widget.onChanged != null) {
          setState(() => loadingSearch = true);
          await widget.onChanged!(value);
          setState(() => loadingSearch = false);
        }
      },
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(CupertinoIcons.search),
        filled: true,
        suffix: loadingSearch
            ? const SizedBox(
                height: 10, width: 10, child: CircularProgressIndicator())
            : widget.controller.text.isNotEmpty
                ? InkWell(
                    child: const Icon(CupertinoIcons.xmark, size: 15),
                    onTap: () => widget.controller.clear())
                : null,
        fillColor: Theme.of(context).cardColor,
      ),
    );
  }
}
