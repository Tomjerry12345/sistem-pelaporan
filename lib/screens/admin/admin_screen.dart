import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

import 'dashboard/laporan-keluar/laporan_keluar_screen.dart';
import 'dashboard/laporan-masuk/laporan_masuk_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBarComponent(
            title: "Notification",
            tab: [
              Tab(
                text: "Laporan masuk",
              ),
              Tab(text: "Laporan keluar"),
            ],
          ),
          body: TabBarView(
            children: [
              LaporanMasukScreen(),
              LaporanKeluarScreen(),
            ],
          )),
    );
  }
}
