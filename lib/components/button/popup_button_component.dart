import 'package:flutter/material.dart';

class PopupButtonComponent extends StatefulWidget {
  final IconData? icon;
  final Function(String value)? onSelected;
  final List<String> items;
  const PopupButtonComponent(
      {super.key, this.icon, this.onSelected, required this.items});

  @override
  State<PopupButtonComponent> createState() => _PopupButtonComponentState();
}

class _PopupButtonComponentState extends State<PopupButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(widget.icon),
      onSelected: widget.onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        ...widget.items.map((e) => PopupMenuItem<String>(
              value: e,
              child: Text(e),
            ))
      ],
    );
  }
}
