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

  final fs = FirebaseServices();

  Future<void> onRegister() async {
    showLoaderDialog();
    String txtNama = nama.text;
    String txtNik = nik.text;
    String txtPassword = password.text;

    try {
      final res = await fs.getDataCollectionByQuery("user", "nik", txtNik);

      if (res.isNotEmpty) {
        showToast("Nik telah terdaftar");
        closeDialog();
        return;
      }
      await fs.addDataCollection(
          "user", {"nama": txtNama, "nik": txtNik, "password": txtPassword, "type": "user"});

      closeDialog();

      navigatePush(const LoginScreen(), isRemove: true);
    } catch (e) {
      showToast(e);
      closeDialog();
    }
  }
}
