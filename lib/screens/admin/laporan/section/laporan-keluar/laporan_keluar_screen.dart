import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/admin/laporan/section/section/detail-laporan/detail_laporan_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';

class LaporanKeluarScreen extends StatefulWidget {
  const LaporanKeluarScreen({super.key});

  @override
  State<LaporanKeluarScreen> createState() => _LaporanKeluarScreenState();
}

class _LaporanKeluarScreenState extends State<LaporanKeluarScreen> {
  final fs = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 24),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: fs.getDataQueryStream("laporan", "type", "keluar"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  final value = data![i].data();
                  return Card(
                    color: Color.fromRGBO(239, 239, 239, 1),
                    child: InkWell(
                      onTap: () {
                        // navigatePush(DetailLaporanScreen(data: value, id: id));
                      },
                      child: ListTile(
                        leading: CircleAvatar(child: Text("A")),
                        title: Text(value["nama"]),
                        subtitle: Text(value["jenis_laporan"]),
                        trailing: Container(
                          color: Colors.green[400],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextComponent(
                              "verifikasi",
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: data?.length,
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }
}
