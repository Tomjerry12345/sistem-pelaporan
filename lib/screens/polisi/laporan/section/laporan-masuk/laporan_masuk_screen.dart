import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/screens/polisi/laporan/section/section/detail-laporan/detail_laporan_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';

class LaporanMasukScreen extends StatefulWidget {
  const LaporanMasukScreen({super.key});

  @override
  State<LaporanMasukScreen> createState() => _LaporanMasukScreenState();
}

class _LaporanMasukScreenState extends State<LaporanMasukScreen> {
  final fs = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 24),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: fs.getDataQueryStream("laporan", "type", "masuk"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  final id = data![i].id;
                  final value = data![i].data();
                  return Card(
                    color: Color.fromRGBO(239, 239, 239, 1),
                    child: InkWell(
                      onTap: () {
                        navigatePush(DetailLaporanScreen(data: value, id: id));
                      },
                      child: ListTile(
                        leading: CircleAvatar(child: Text("A")),
                        title: Text(value["nama"]),
                        subtitle: Text(value["jenis_laporan"]),
                        trailing: Icon(Icons.arrow_right),
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
