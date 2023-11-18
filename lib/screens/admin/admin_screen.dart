import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

import 'dashboard/dashboard_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(
          title: "",
          rightOnPressed: () {
            logO("klik");
            SharedPreferencesUtils.reset(key: "nama");
            navigatePush(LoginScreen(), isRemove: true);
          },
        ),
        body: DashboardScreen());
  }
}
