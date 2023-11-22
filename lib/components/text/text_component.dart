import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final double size;
  final Color color;
  final int? maxLines;

  const TextComponent(this.text,
      {super.key,
      this.weight = FontWeight.w900,
      this.size = 24,
      this.color = Colors.black,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: "Lato", fontWeight: weight, fontSize: size, color: color),
    );
  }
}
