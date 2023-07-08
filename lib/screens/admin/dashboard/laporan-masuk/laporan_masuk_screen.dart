import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/admin/dashboard/section/detail-laporan/detail_laporan_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';

class LaporanMasukScreen extends StatefulWidget {
  const LaporanMasukScreen({super.key});

  @override
  State<LaporanMasukScreen> createState() => _LaporanMasukScreenState();
}

class _LaporanMasukScreenState extends State<LaporanMasukScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          return Card(
            color: Color.fromRGBO(239, 239, 239, 1),
            child: InkWell(
              onTap: () {
                navigatePush(DetailLaporanScreen());
              },
              child: ListTile(
                leading: CircleAvatar(child: Text('A')),
                title: Text('Headline'),
                subtitle: Text('Supporting text'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          );
        },
        itemCount: 5,
      ),
    ));
  }
}
