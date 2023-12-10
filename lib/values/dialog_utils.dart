import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/models/item_menu_dialog.dart';

Widget menuDialog(context, List<ItemMenuDialog> listMenu) {
  return SimpleDialog(
      title: const Text('Pilih Menu'),
      children: listMenu
          .map(
            (e) => SimpleDialogOption(
              onPressed: () {
                if (e.onPressed != null) e.onPressed!();
                dialogClose(context);
              },
              child: Text(e.title),
            ),
          )
          .toList());
}

Future<void> dialogShow({context, title, content, actions}) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextComponent(
            title,
            size: 18,
            weight: FontWeight.w600,
          ),
          content: content,
          actions: actions,
        );
      });
}

void dialogClose(context) {
  Navigator.of(context).pop();
}
