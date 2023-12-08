import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_dropdown_component%20.dart';
import 'package:sistem_pelaporan/screens/polisi/laporan/section/section/detail-laporan/detail_laporan_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/date_utils.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

class AllLaporanScreen extends StatefulWidget {
  const AllLaporanScreen({super.key});

  @override
  State<AllLaporanScreen> createState() => _AllLaporanScreenState();
}

class _AllLaporanScreenState extends State<AllLaporanScreen> {
  final fs = FirebaseServices();
  final date = formatDate(getTimeNow());

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
              orderBy: "tanggal"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              if (data!.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (ctx, i) {
                    final id = data[i].id;
                    final value = data[i].data();
                    logO(value);
                    return Card(
                      color: Color.fromRGBO(239, 239, 239, 1),
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
                            // !value["konfirmasi_polisi"]
                            //     ? ButtonElevatedComponent(
                            //         "segera ke sana",
                            //         w: 104,
                            //         size: 10,
                            //         onPressed: () async {
                            //           await fs.updateDataSpecifictDoc(
                            //               "laporan", id, {
                            //             "notifikasi": true,
                            //             "konfirmasi_polisi": true
                            //           });
                            //         },
                            //       )
                            //     : Container(),
                            IconButton(
                              icon: Icon(Icons.notifications),
                              onPressed: () {},
                            ),

                            // ButtonElevatedComponent(
                            //   "Tolak laporan",
                            //   w: 104,
                            //   size: 10,
                            //   bg: Colors.red,
                            //   onPressed: () async {
                            //     await fs.updateDataSpecifictDoc("laporan", id, {
                            //       "notifikasi": true,
                            //       "konfirmasi_polisi": true
                            //     });
                            //   },
                            // ),
                            // H(8),
                            IconButton(
                              icon: Icon(Icons.do_not_disturb),
                              color: Colors.red,
                              onPressed: () {},
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                );
              }

              return Center(
                child: TextComponent("Tidak ada laporan"),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }
}
