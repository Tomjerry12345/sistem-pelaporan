import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_pelaporan/screens/pelapor/pelapor_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

class Logic {
  final nik = TextEditingController();
  final password = TextEditingController();

  final fs = FirebaseServices();

  final sharedPreferencesUtils = SharedPreferencesUtils();

  Future<void> onLogin() async {
    showLoaderDialog();
    String txtNik = nik.text;
    String txtPassword = password.text;

    try {
      if (txtNik.length != 16) {
        throw ArgumentError("Nik harus memiliki 16 nomor");
      }

      final res = await fs.getDataCollectionByQuery("user", "nik", txtNik);

      if (res.isNotEmpty) {
        final d = res[0];

        if (txtPassword == d["password"]) {
          sharedPreferencesUtils.set(type: "string", key: "nama", value: d["nama"]);
          navigatePush(const PelaporScreen(), isRemove: true);
          // if (d["type"] == "admin") {
          //   navigatePush(const AdminScreen(), isRemove: true);
          // } else {
          //   navigatePush(const PelaporScreen(), isRemove: true);
          // }
        } else {
          showToast("Password salah");
          closeDialog();
        }
      } else {
        showToast("NIK tidak di temukan");
        closeDialog();
      }
    } catch (e) {
      showToast(e);
      closeDialog();
    }
  }
}
