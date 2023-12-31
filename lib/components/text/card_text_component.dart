import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';
import 'text_component.dart';

class CardTextComponent extends StatelessWidget {
  final String label, data;
  const CardTextComponent(this.label, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          label,
          size: 18,
          color: Colors.white,
        ),
        V(8),
        Card(
          elevation: 8,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 1.0.w,
              child: TextComponent(
                data,
                size: 16,
                weight: FW.light,
              ),
            ),
          ),
        )
      ],
    );
  }
}
