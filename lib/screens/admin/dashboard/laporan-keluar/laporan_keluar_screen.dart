import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

class LaporanKeluarScreen extends StatefulWidget {
  const LaporanKeluarScreen({super.key});

  @override
  State<LaporanKeluarScreen> createState() => _LaporanKeluarScreenState();
}

class _LaporanKeluarScreenState extends State<LaporanKeluarScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: TextComponent("Laporan keluar")));
  }
}
