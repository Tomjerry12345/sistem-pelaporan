import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';

class Logic {
  final nama = TextEditingController();
  final email = TextEditingController();
  final nik = TextEditingController();
  final jenisKelamin = SingleValueDropDownController();
  final noTelepon = TextEditingController();
  final password = TextEditingController();

  File? getImage;

  final fs = FirebaseServices();

  void onPickImage(image, setState) {
    setState(() {
      getImage = image;
    });
  }

  Future<void> onRegister() async {
    try {
      showLoaderDialog();
      String txtNama = nama.text;
      String txtEmail = email.text;
      String txtNik = nik.text;
      String txtJenisKelamin = jenisKelamin.dropDownValue?.value;
      String txtNoTelepon = noTelepon.text;
      String txtPassword = password.text;
      if (txtNama.isEmpty ||
          txtEmail.isEmpty ||
          txtNik.isEmpty ||
          txtJenisKelamin.isEmpty ||
          txtNoTelepon.isEmpty ||
          txtPassword.isEmpty) {
        throw ArgumentError("Inputan tidak boleh kosong");
      }

      if (getImage == null) throw ArgumentError("image belum di pilih");

      if (txtNik.length != 16) {
        throw ArgumentError("Nik harus memiliki 16 nomor");
      }

      final res = await fs.getDataCollectionByQuery("user", "nik", txtNik);

      UserCredential? resUser;

      if (res.isEmpty) {
        resUser = await fs.registerWithEmailAndPassword(txtEmail, txtPassword);
      } else {
        final d = res.first.data();
        resUser = await fs.signInWithEmailAndPassword(d["email"], d["password"]);
      }

      final user = resUser.user;

      final isVerified = user?.emailVerified;

      logO("isVerified", m: isVerified);

      if (!isVerified!) {
        if (!res.isNotEmpty) {
          final urlFile = await fs.uploadFile(getImage!, "profile");

          final data = {
            "image": urlFile,
            "nama": txtNama,
            "email": txtEmail,
            "nik": txtNik,
            "jenis_kelamin": txtNama,
            "no_telepon": txtNama,
            "password": txtPassword,
            "type": "user"
          };
          await fs.addDataCollection("user", data);
        }

        await user?.sendEmailVerification();

        showSnackbar("Silahkan cek email anda untuk verifikasi",
            color: "e");
      } else {
         showSnackbar("Akun sudah terdaftar silahkan lanjut login",
            color: "s");
      }

      closeDialog();

      navigatePush(const LoginScreen(), isRemove: true);
    } catch (e) {
      logO(e);
      showSnackbar(e, color: "e");
      closeDialog();
    }
  }
}
