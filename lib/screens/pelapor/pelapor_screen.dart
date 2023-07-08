import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

class PelaporScreen extends StatefulWidget {
  const PelaporScreen({super.key});

  @override
  State<PelaporScreen> createState() => _PelaporScreenState();
}

class _PelaporScreenState extends State<PelaporScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextComponent("Pelapor"),
      ),
    );
  }
}
