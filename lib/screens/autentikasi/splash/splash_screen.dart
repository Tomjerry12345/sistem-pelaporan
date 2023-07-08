import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/screens/autentikasi/register/register_screen.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/widget_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Container(
                  width: 0.6.w, height: 0.6.h, child: Image.asset("assets/images/bg_splash.png"))),
          TextComponent(
            "Selamat datang kembali",
            size: 24,
          ),
          V(16),
          TextComponent(
              "ini adalah Sistem pengaduan dan titik lokasi tindakan kriminal di kota makassaar.",
              size: 16,
              weight: FW.light),
          V(8),
          TextComponent("Silahkan login atau mendaftar terlebih dahulu untuk melanjutkan.",
              size: 16, weight: FW.light),
          V(0.1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonElevatedComponent("Login", onPressed: () {
                navigatePush(const LoginScreen());
              }, w: 0.4.w),
              ButtonElevatedComponent("Register", onPressed: () {
                navigatePush(const RegisterScreen());
              }, bg: Colors.white, fg: Colors.black, w: 0.4.w),
            ],
          )
        ],
      ),
    ));
  }
}