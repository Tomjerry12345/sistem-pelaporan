import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/polisi/laporan/section/section/detail-laporan/detail_laporan_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

class HistoriPelaporScreen extends StatefulWidget {
  const HistoriPelaporScreen({super.key});

  @override
  State<HistoriPelaporScreen> createState() => _HistoriPelaporScreenState();
}

class _HistoriPelaporScreenState extends State<HistoriPelaporScreen> {
  final fs = FirebaseServices();

  bool sortClick = false;

  @override
  Widget build(BuildContext context) {
    final user = fs.getUser();
    return Scaffold(
        appBar: AppBarComponent(
            title: "Laporan",
            icLeft: Icons.arrow_back,
            leftOnPressed: () {
              navigatePop();
            },
            icRight: !sortClick ? Icons.sort : Icons.segment,
            rightOnPressed: () {
              setState(() {
                sortClick = !sortClick;
              });
            },
            height: 120),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: fs.getDataQueryStream(
                "laporan",
                [
                  {"key": "email", "value": user?.email}
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
                      return !sortClick
                          ? aTimestamp.compareTo(bTimestamp)
                          : bTimestamp.compareTo(aTimestamp);
                    });
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
                              title: TextComponent(value["nama"], size: 14),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  V(4),
                                  TextComponent(
                                    value["jenis_laporan"],
                                    size: 14,
                                    weight: FontWeight.normal,
                                  ),
                                  V(8),
                                  !value["konfirmasi"]
                                      ? TextComponent(
                                          value["message_tolak"],
                                          size: 14,
                                          weight: FontWeight.w200,
                                        )
                                      : Container(),
                                ],
                              ),
                              trailing: !value["konfirmasi"]
                                  ? TextComponent(
                                      "Di tolak",
                                      size: 14,
                                      color: Colors.red,
                                    )
                                  : Container(
                                      width: 10,
                                    ),
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
                  child: TextComponent("Tidak ada laporan"),
                );
              }),
        ));
  }
}
