import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/date_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/pick_file_utils.dart';

import '../../../../components/pick_maps/pick_maps.dart';
import '../../../../values/navigate_utils.dart';

class Logic {
  final fs = FirebaseServices();

  TextEditingController namaPelapor = TextEditingController();
  TextEditingController jenisLaporan = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController noTelepon = TextEditingController();

  File? file;
  String typeFile = "";
  Map location = {};

  Future<void> onPickFile(key, setState) async {
    File? p;
    String? typeFile;
    if (key == "image") {
      p = await pickImage();
      typeFile = "image";
    } else {
      p = await pickVideo();
      typeFile = "video";
    }

    setState(() {
      file = p;
      typeFile = typeFile;
    });
  }

  Future<void> onPickMaps(setState) async {
    final result = await navigatePush(const PickMapsComponent());
    setState(() {
      location = {
        "latitude": result.latitude,
        "longitude": result.longitude,
      };
    });
  }

  Future<void> onAdd() async {
    showLoaderDialog();
    final txtNamaPelapor = namaPelapor.text;
    final txtJenisLaporan = jenisLaporan.text;
    final txtDeskripsi = deskripsi.text;
    final txtNoTelepon = noTelepon.text;

    // final file = image ?? video;

    if (txtNamaPelapor != "" &&
        txtJenisLaporan != "" &&
        txtDeskripsi != "" &&
        txtNoTelepon != "" &&
        file != null &&
        location.isNotEmpty) {
      try {
        if (file == null) throw ArgumentError("file belum di pilih");
        final urlFile = await fs.uploadFile(file!, "laporan");
        final date = formatDate(getTimeNow());
        final req = {
          "nama": txtNamaPelapor,
          "jenis_laporan": txtJenisLaporan,
          "deskripsi": txtDeskripsi,
          "no_telepon": txtNoTelepon,
          "file": urlFile,
          "type": "masuk",
          "lokasi": location,
          "type_file": typeFile,
          "tanggal": "${date["month"]}, ${date["day"]} ${date["year"]}"
        };

        fs.addDataCollection("laporan", req);

        closeDialog();

        navigatePop();
      } catch (e) {
        closeDialog();
        logO("error tambah laporan", m: e);
        showToast(e);
      }
    } else {
      closeDialog();
      showToast("Inputan tidak boleh kosong!");
    }
  }
}
