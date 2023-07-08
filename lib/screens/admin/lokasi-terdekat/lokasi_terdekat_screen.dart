import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

class LokasiTerdekatScreen extends StatefulWidget {
  const LokasiTerdekatScreen({super.key});

  @override
  State<LokasiTerdekatScreen> createState() => _LokasiTerdekatScreenState();
}

class _LokasiTerdekatScreenState extends State<LokasiTerdekatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: TextComponent("Lokasi terdekat")));
  }
}
