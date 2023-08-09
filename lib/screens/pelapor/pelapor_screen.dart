import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';

import 'dashboard/dashboard_screen.dart';

class PelaporScreen extends StatefulWidget {
  const PelaporScreen({super.key});

  @override
  State<PelaporScreen> createState() => _PelaporScreenState();
}

class _PelaporScreenState extends State<PelaporScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBarComponent(title: "", rightOnPressed: navigatePush(LoginScreen(), isRemove: true)),
        body: DashboardScreen());
  }
}
