import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

class TambahLaporanScreen extends StatefulWidget {
  const TambahLaporanScreen({super.key});

  @override
  State<TambahLaporanScreen> createState() => _TambahLaporanScreenState();
}

class _TambahLaporanScreenState extends State<TambahLaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: TextComponent("Tambah laporan")));
  }
}
