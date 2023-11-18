import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_dropdown_component%20.dart';
import 'package:sistem_pelaporan/values/pick_file_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

import 'logic.dart';

class TambahLaporanScreen extends StatefulWidget {
  const TambahLaporanScreen({super.key});

  @override
  State<TambahLaporanScreen> createState() => _TambahLaporanScreenState();
}

class _TambahLaporanScreenState extends State<TambahLaporanScreen> {
  final l = Logic();
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
                  controller: l.namaPelapor,
                  enabled: false,
                ),
                V(16),
                TextfieldDropdownComponent(
                  hintText: "Jenis laporan",
                  controller: l.jenisLaporan,
                  items: const [
                    {"name": "Perampokan", "value": "Perampokan"},
                    {"name": "Begal", "value": "Begal"}
                  ],
                ),
                V(16),
                TextfieldComponent(
                  label: "Kejadian seperti apa?",
                  controller: l.deskripsi,
                ),
                V(16),
                TextfieldComponent(
                  inputType: TextInputType.number,
                  label: "No telepon alternatif",
                  controller: l.noTelepon,
                ),
                V(16),
                TextfieldComponent(
                  inputType: TextInputType.streetAddress,
                  label: "Alamat",
                  controller: l.noTelepon,
                ),
                V(32),
                Center(
                  child: l.loadingImage
                      ? CircularProgressIndicator()
                      : l.file != null
                          ? Wrap(
                              direction: Axis.vertical,
                              children: [
                                Container(
                                  width: 250,
                                  child: TextComponent(
                                    getNameFile(l.file!),
                                    size: 14,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                ),
                V(24),
                Center(
                  child: ButtonElevatedComponent(
                    "Bukti Video",
                    onPressed: () {
                      // dialogShow(
                      //     context: context,
                      //     widget: menuDialog(context, [
                      //       ItemMenuDialog(
                      //           title: "Pilih image",
                      //           onPressed: () {
                      //             l.onPickFile("image", setState);
                      //           }),
                      //       ItemMenuDialog(
                      //           title: "Pilih video",
                      //           onPressed: () async {
                      //             l.onPickFile("video", setState);
                      //           })
                      //     ]));
                      l.onPickFile("video", setState);
                    },
                    bg: Colors.orange,
                    w: 0.6.w,
                  ),
                ),
                V(16),
                // Center(
                //   child: l.location.isNotEmpty
                //       ? Wrap(
                //           direction: Axis.vertical,
                //           children: [
                //             Container(
                //               width: 200,
                //               child: TextComponent(
                //                 "${l.location}",
                //                 size: 14,
                //               ),
                //             ),
                //             V(8),
                //           ],
                //         )
                //       : Container(),
                // ),
                // Center(
                //   child: ButtonElevatedComponent(
                //     "Pilih lokasi pelaporan",
                //     onPressed: () async {
                //       l.onPickMaps(setState);
                //     },
                //     bg: Colors.red,
                //     w: 0.6.w,
                //   ),
                // ),
                V(24),
                Center(
                  child: ButtonElevatedComponent("Kirim laporan", onPressed: () async {
                    l.onAdd();
                  }, w: 1.0.w),
                ),
              ],
            ),
          ),
        ));
  }
}
