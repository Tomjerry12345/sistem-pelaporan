import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/date_utils.dart';
import 'package:sistem_pelaporan/values/global_utils.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/pick_file_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

class Logic {
  final fs = FirebaseServices();

  TextEditingController namaPelapor = TextEditingController();
  SingleValueDropDownController jenisLaporan = SingleValueDropDownController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController noTelepon = TextEditingController();
  TextEditingController alamat = TextEditingController();

  File? file;
  String typeFile = "";
  Map location = {};
  bool loadingImage = false;

  Logic() {
    onGet();
  }

  Future<void> onGet() async {
    namaPelapor.text = await SharedPreferencesUtils.get(key: "nama");
  }

  Future<void> onPickFile(key, setState) async {
    try {
      setState(() {
        loadingImage = true;
      });
      File? p;
      String typeFile;
      if (key == "image") {
        p = await pickImage();
        typeFile = "image";
      } else {
        p = await pickVideo();
        typeFile = "video";
      }

      setState(() {
        loadingImage = false;
        file = p;
        this.typeFile = typeFile;
      });
    } catch (e) {
      setState(() {
        loadingImage = false;
      });
      showToast(e);
    }
  }

  // Future<void> onPickMaps(setState) async {
  //   final result = await navigatePush(const PickMapsComponent());
  //   setState(() {
  //     location = {
  //       "latitude": result.latitude,
  //       "longitude": result.longitude,
  //     };
  //   });
  // }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      print('Latitude: $latitude, Longitude: $longitude');
      processingAdd(latitude, longitude);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> processingAdd(double latitude, double longitude) async {
    try {
      showLoaderDialog();

      final txtNamaPelapor = namaPelapor.text;
      final txtJenisLaporan = jenisLaporan.dropDownValue?.value;
      final txtDeskripsi = deskripsi.text;
      final txtNoTelepon = noTelepon.text;
      final txtAlamat = alamat.text;

      final user = fs.getUser();

      // final file = image ?? video;
      if (txtNamaPelapor == "" &&
          txtJenisLaporan == "" &&
          txtDeskripsi == "" &&
          txtNoTelepon == "" &&
          txtAlamat == "") {
        throw ArgumentError("Inputan tidak boleh kosong!");
      }
      if (file == null) throw ArgumentError("file belum di pilih");
      final urlFile = await fs.uploadFile(file!, "laporan");
      final date = formatDate(getTimeNow());
      final req = {
        "email": user?.email,
        "nama": txtNamaPelapor,
        "jenis_laporan": txtJenisLaporan,
        "deskripsi": txtDeskripsi,
        "no_telepon": txtNoTelepon,
        "file": urlFile,
        "type": "masuk",
        "lokasi": {"latitude": latitude, "longitude": longitude},
        "type_file": typeFile,
        "tanggal": "${date["month"]}, ${date["day"]} ${date["year"]}",
        "konfirmasi": true,
        "notifikasi": false,
        "created": getTimeNow().millisecondsSinceEpoch
      };

      fs.addDataCollection("laporan", req);

      closeDialog();

      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: ctx,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Berhasil',
        desc: 'Laporan anda sedang di verifikasi',
        btnOkOnPress: () {
          navigatePop();
        },
      ).show();
    } catch (e) {
      closeDialog();
      showSnackbar(e, color: "e");
    }
  }

  Future<void> onAdd() async {
    getCurrentLocation();
  }
}
