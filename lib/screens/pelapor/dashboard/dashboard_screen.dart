import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: TextComponent("Dashboard")));
  }
}
