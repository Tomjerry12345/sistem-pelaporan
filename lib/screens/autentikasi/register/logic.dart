import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';

class Logic {
  final nama = TextEditingController();
  final nik = TextEditingController();
  final password = TextEditingController();

  File? getImage;

  final fs = FirebaseServices();

  void onPickImage(image, setState) {
    setState(() {
      getImage = image;
    });
  }

  Future<void> onRegister() async {
    showLoaderDialog();
    String txtNama = nama.text;
    String txtNik = nik.text;
    String txtPassword = password.text;

    try {
      if (txtNik.length != 16) {
        throw ArgumentError("Nik harus memiliki 16 nomor");
      }
      final res = await fs.getDataCollectionByQuery("user", "nik", txtNik);

      if (res.isNotEmpty) {
        throw ArgumentError("Nik telah terdaftar");
      }

      if (getImage == null) throw ArgumentError("image belum di pilih");
      final urlFile = await fs.uploadFile(getImage!, "profile");

      await fs.addDataCollection("user", {
        "image": urlFile,
        "nama": txtNama,
        "nik": txtNik,
        "password": txtPassword,
        "type": "user"
      });

      closeDialog();

      navigatePush(const LoginScreen(), isRemove: true);
    } catch (e) {
      showToast(e);
      closeDialog();
    }
  }
}
