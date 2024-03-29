import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';

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
          stream: fs.getDataQueryStream("laporan", [
            {"key": "type", "value": "keluar"}
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  final value = data![i].data();
                  return Card(
                    color: const Color.fromRGBO(239, 239, 239, 1),
                    child: InkWell(
                      onTap: () {
                        // navigatePush(DetailLaporanScreen(data: value, id: id));
                      },
                      child: ListTile(
                        leading: const CircleAvatar(child: Text("A")),
                        title: Text(value["nama"]),
                        subtitle: Text(value["jenis_laporan"]),
                        trailing: Container(
                          color: Colors.green[400],
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
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

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }
}
