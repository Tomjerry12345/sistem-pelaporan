import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/pick_maps/pick_maps.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/models/item_menu_dialog.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/date_utils.dart';
import 'package:sistem_pelaporan/values/dialog_utils.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/pick_file_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

class TambahLaporanScreen extends StatefulWidget {
  const TambahLaporanScreen({super.key});

  @override
  State<TambahLaporanScreen> createState() => _TambahLaporanScreenState();
}

class _TambahLaporanScreenState extends State<TambahLaporanScreen> {
  final fs = FirebaseServices();

  TextEditingController namaPelapor = TextEditingController();
  TextEditingController jenisLaporan = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController noTelepon = TextEditingController();

  File? file;
  String typeFile = "";
  Map location = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 0.1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextComponent(
                  "Pelaporan",
                ),
                V(48),
                TextfieldComponent(
                  label: "Nama pelapor",
                  controller: namaPelapor,
                ),
                V(16),
                TextfieldComponent(
                  label: "Jenis laporan",
                  controller: jenisLaporan,
                ),
                V(16),
                TextfieldComponent(
                  label: "Deskripsi",
                  controller: deskripsi,
                ),
                V(16),
                TextfieldComponent(
                  label: "No telepon",
                  controller: noTelepon,
                ),
                V(32),
                Center(
                  child: file != null
                      ? Wrap(
                          direction: Axis.vertical,
                          children: [
                            TextComponent(
                              getNameFile(file!),
                              size: 14,
                            ),
                            V(8),
                          ],
                        )
                      : Container(),
                ),
                Center(
                  child: ButtonElevatedComponent(
                    "Foto / Bukti video",
                    onPressed: () {
                      dialogShow(
                          context: context,
                          widget: menuDialog(context, [
                            ItemMenuDialog(
                                title: "Pilih image",
                                onPressed: () async {
                                  final p = await pickImage();
                                  setState(() {
                                    file = p;
                                    typeFile = "image";
                                  });
                                }),
                            ItemMenuDialog(
                                title: "Pilih video",
                                onPressed: () async {
                                  final p = await pickVideo();
                                  setState(() {
                                    file = p;
                                    typeFile = "video";
                                  });
                                })
                          ]));
                    },
                    bg: Colors.orange,
                    w: 0.6.w,
                  ),
                ),
                V(16),
                Center(
                  child: location.isNotEmpty
                      ? Wrap(
                          direction: Axis.vertical,
                          children: [
                            Container(
                              width: 200,
                              child: TextComponent(
                                "$location",
                                size: 14,
                              ),
                            ),
                            V(8),
                          ],
                        )
                      : Container(),
                ),
                Center(
                  child: ButtonElevatedComponent(
                    "Pilih lokasi pelaporan",
                    onPressed: () async {
                      final result = await navigatePush(PickMapsComponent());
                      setState(() {
                        location = {
                          "latitude": result.latitude,
                          "longitude": result.longitude,
                        };
                      });
                    },
                    bg: Colors.red,
                    w: 0.6.w,
                  ),
                ),
                V(48),
                Center(
                  child: ButtonElevatedComponent("Kirim laporan", onPressed: () async {
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
                  }, w: 1.0.w),
                ),
              ],
            ),
          ),
        ));
  }
}
