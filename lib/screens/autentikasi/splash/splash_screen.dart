import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/screens/autentikasi/register/register_screen.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';
import 'logic.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Logic();
    
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: SizedBox(
                  width: 0.6.w, height: 0.6.h, child: Image.asset("assets/images/bg_splash.png"))),
          const TextComponent(
            "Selamat datang kembali",
            size: 24,
          ),
          V(16),
          const TextComponent(
              "ini adalah Sistem pengaduan dan titik lokasi tindakan kriminal di kota makassaar.",
              size: 16,
              weight: FW.light),
          V(8),
          const TextComponent("Silahkan login atau mendaftar terlebih dahulu untuk melanjutkan.",
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
