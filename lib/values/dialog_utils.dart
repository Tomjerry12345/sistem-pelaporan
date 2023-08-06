import 'package:flutter/material.dart';
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

Future<void> dialogShow({context, widget}) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return widget;
      });
}

void dialogClose(context) {
  Navigator.of(context).pop();
}
