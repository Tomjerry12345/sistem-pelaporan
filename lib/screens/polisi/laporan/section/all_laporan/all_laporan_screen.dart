import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/button/popup_button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/screens/polisi/globals/detail-laporan/detail_laporan_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/date_utils.dart';
import 'package:sistem_pelaporan/values/dialog_utils.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';

class AllLaporanScreen extends StatefulWidget {
  const AllLaporanScreen({super.key});

  @override
  State<AllLaporanScreen> createState() => _AllLaporanScreenState();
}

class _AllLaporanScreenState extends State<AllLaporanScreen> {
  final fs = FirebaseServices();
  final date = formatDate(getTimeNow());

  final txtAlasanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 24),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: fs.getDataQueryStream(
            "laporan",
            [
              {
                "key": "tanggal",
                "value": "${date["month"]}, ${date["day"]} ${date["year"]}"
              }
            ],
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>>? data =
                  snapshot.data?.docs;
              if (data!.isNotEmpty) {
                data.sort((a, b) {
                  var aTimestamp = a.data()['created'];
                  var bTimestamp = b.data()['created'];
                  return aTimestamp.compareTo(bTimestamp);
                });
                return ListView.builder(
                  itemBuilder: (ctx, i) {
                    final id = data[i].id;
                    final value = data[i].data();
                    return Card(
                      color: const Color.fromRGBO(239, 239, 239, 1),
                      child: InkWell(
                        onTap: () {
                          navigatePush(
                              DetailLaporanScreen(data: value, id: id));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Text(value["nama"]
                                  .toString()
                                  .characters
                                  .first
                                  .toUpperCase())),
                          title: Text(value["nama"]),
                          subtitle: Text(value["jenis_laporan"]),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            PopupButtonComponent(
                              icon: Icons.notifications,
                              onSelected: (value) async {
                                await fs.updateDataSpecifictDoc("laporan", id, {
                                  "notifikasi": true,
                                  "message_notif": value
                                });
                                showSnackbar("Mengirim notifikasi ke pelapor");
                              },
                              items: const ["Segera ke lokasi", "Sampai ke lokasi"],
                            ),
	                      value["konfirmasi"] ?
                            IconButton(
                              icon: const Icon(Icons.do_not_disturb),
                              color: Colors.red,
                              onPressed: () async {
                                await dialogShow(
                                    context: context,
                                    title: "Alasan Menolak",
                                    content: SizedBox(
                                      width: 100,
                                      child: TextfieldComponent(
                                        controller: txtAlasanController,
                                        size: 14,
                                        maxLines: 4,
                                      ),
                                    ),
                                    actions: [
                                      ButtonElevatedComponent("Kirim",
                                          size: 14,
                                          h: 48,
                                          w: 80, onPressed: () async {
                                        await fs.updateDataSpecifictDoc(
                                            "laporan", id, {
                                          "konfirmasi": false,
                                          "message_tolak":
                                              txtAlasanController.text
                                        });
                                        setState(() {
                                          txtAlasanController.text = "";
                                        });
                                        // ignore: use_build_context_synchronously
                                        dialogClose(context);
                                      })
                                    ]);
                              },
                            ) : Container()
                          ]),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                );
              }

              return const Center(
                child: TextComponent("Tidak ada laporan"),
              );
            }

            return const Center(
              child: TextComponent("Tidak ada laporan"),
            );
          }),
    ));
  }
}
