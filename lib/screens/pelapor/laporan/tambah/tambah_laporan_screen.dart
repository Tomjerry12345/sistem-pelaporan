import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/models/item_menu_dialog.dart';
import 'package:sistem_pelaporan/values/dialog_utils.dart';
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
                ),
                V(16),
                TextfieldComponent(
                  label: "Jenis laporan",
                  controller: l.jenisLaporan,
                ),
                V(16),
                TextfieldComponent(
                  label: "Deskripsi",
                  controller: l.deskripsi,
                ),
                V(16),
                TextfieldComponent(
                  inputType: TextInputType.number,
                  label: "No telepon",
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
                                TextComponent(
                                  getNameFile(l.file!),
                                  size: 14,
                                ),
                              ],
                            )
                          : Container(),
                ),
                V(24),
                Center(
                  child: ButtonElevatedComponent(
                    "Foto / Bukti video",
                    onPressed: () {
                      dialogShow(
                          context: context,
                          widget: menuDialog(context, [
                            ItemMenuDialog(
                                title: "Pilih image",
                                onPressed: () {
                                  l.onPickFile("image", setState);
                                }),
                            ItemMenuDialog(
                                title: "Pilih video",
                                onPressed: () async {
                                  l.onPickFile("video", setState);
                                })
                          ]));
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
