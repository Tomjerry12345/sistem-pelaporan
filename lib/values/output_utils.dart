import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/values/color.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

import 'global_utils.dart';

void showToast(msg) {
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void logO(t, {dynamic m = ""}) {
  m == "" ? print("[d] $t") : print("[d] $t: $m");
}

showLoaderDialog() {
  AlertDialog alert = AlertDialog(
    content: Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: SpinKitWave(
              color: Colors.black,
              size: 50.0,
            ),
          ),
          V(16),
          Container(
              child: const TextComponent(
            "Loading...",
            size: 18,
            weight: FW.light,
          )),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: ctx,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

closeDialog() {
  Navigator.of(ctx, rootNavigator: true).pop();
}

/// [color] merupakan opsi yang bisa berisi nilai s untuk warna success atau e untuk warna error atau hexadesimal atau Color.
void showSnackbar(text, {dynamic color = "s"}) {
  final messengerKey = GlobalContext.messengerKey;
  if (text == null) return;

  Color? c;

  if (color == "s") {
    c = Colors.green;
  } else if (color == "e") {
    c = Colors.red;
  } else if (color.characters.first == "#") {
    c = hexToColor(color);
  } else {
    c = color;
  }

  final snakBar = SnackBar(content: Text("$text"), backgroundColor: c);

  messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snakBar);
}

