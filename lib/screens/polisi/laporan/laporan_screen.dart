import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/screens/polisi/laporan/section/all_laporan/all_laporan_screen.dart';

import 'section/laporan-keluar/laporan_keluar_screen.dart';
import 'section/laporan-masuk/laporan_masuk_screen.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBarComponent(
            title: "Laporan",
            // tab: [
            //   Tab(
            //     text: "Laporan masuk",
            //   ),
            //   Tab(text: "Laporan keluar"),
            // ],
          ),
          // body: TabBarView(
          //   children: [
          //     LaporanMasukScreen(),
          //     LaporanKeluarScreen(),
          //   ],
          // ),
          body: AllLaporanScreen()
          ),
    );
  }
}
