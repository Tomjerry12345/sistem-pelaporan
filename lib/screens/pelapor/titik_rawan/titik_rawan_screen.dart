import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

class TitikRawanScreen extends StatefulWidget {
  const TitikRawanScreen({super.key});

  @override
  State<TitikRawanScreen> createState() => _TitikRawanScreenState();
}

class _TitikRawanScreenState extends State<TitikRawanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: TextComponent("Titik rawan")));
  }
}
