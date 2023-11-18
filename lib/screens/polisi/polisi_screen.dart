import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

import 'dashboard/dashboard_screen.dart';

class PolisiScreen extends StatefulWidget {
  const PolisiScreen({super.key});

  @override
  State<PolisiScreen> createState() => _PolisiScreenState();
}

class _PolisiScreenState extends State<PolisiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(
          title: "",
          rightOnPressed: () {
            SharedPreferencesUtils.reset(key: "nama");
            navigatePush(LoginScreen(), isRemove: true);
          },
        ),
        body: DashboardScreen());
  }
}
