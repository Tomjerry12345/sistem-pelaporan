import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_pelaporan/screens/polisi/polisi_screen.dart';
import 'package:sistem_pelaporan/screens/autentikasi/lupa-password/lupa_password_screen.dart';
import 'package:sistem_pelaporan/screens/pelapor/pelapor_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

class Logic {
  final nik = TextEditingController();
  final password = TextEditingController();

  final fs = FirebaseServices();

  final FocusNode focusNode = FocusNode();

  // final sharedPreferencesUtils = SharedPreferencesUtils();

  Future<void> onLogin() async {
    focusNode.unfocus();
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

        final resUser =
            await fs.signInWithEmailAndPassword(d["email"], txtPassword);
        final user = resUser.user;

        if (user?.emailVerified == true) {
          SharedPreferencesUtils.set(key: "nama", value: d["nama"]);
          // navigatePush(const PelaporScreen(), isRemove: true);
          if (d["type"] == "polisi") {
            navigatePush(const PolisiScreen(), isRemove: true);
          } else {
            navigatePush(const PelaporScreen(), isRemove: true);
          }
        } else {
          await user?.sendEmailVerification();
          throw ArgumentError(
              "Email belum di verifikasi, silahkan cek email untuk verifikasi");
        }
      } else {
        throw ArgumentError("NIK tidak di temukan");
      }
    } catch (e) {
      showSnackbar(e, color: "e");
      closeDialog();
    }
  }

  void onLupaPassword() {
    navigatePush(LupaPasswordScreen());
  }
}
