import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';

class Logic {
  final email = TextEditingController();
  final password = TextEditingController();

  final fs = FirebaseServices();

  Future<void> onVerifikasi() async {
    showLoaderDialog();
    String txtEmail = email.text;

    try {
      if (txtEmail.isEmpty) {
        throw ArgumentError("Email tidak boleh kosong");
      }

      await fs.resetPassword(txtEmail);

      showSnackbar("Email reset password sudah terkirim, silahkan cek email anda");

      closeDialog();

      navigatePop();

    } catch (e) {
      showSnackbar(e, color: "e");
      closeDialog();
    }
  }
}
