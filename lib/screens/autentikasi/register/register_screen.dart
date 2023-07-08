import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/widget_utils.dart';

import 'logic.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final l = Logic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              V(0.1.h),
              const TextComponent(
                "Register",
                size: 24,
              ),
              V(16),
              TextComponent("Silahkan registrasi terlebih dahulu untuk melanjutkan",
                  size: 16, weight: FW.light),
              V(48),
              TextfieldComponent(
                label: "Nama",
                controller: l.nama,
              ),
              V(24),
              TextfieldComponent(
                label: "NIK",
                controller: l.nik,
              ),
              V(24),
              TextfieldComponent(
                label: "Password",
                controller: l.password,
              ),
              V(48),
              ButtonElevatedComponent(
                "Register",
                onPressed: () {
                  l.onRegister();
                },
                w: 1.0.w,
              ),
              V(24),
              ButtonElevatedComponent(
                "Login",
                onPressed: () {
                  navigatePush(LoginScreen(), isRemove: true);
                },
                w: 1.0.w,
                bg: Colors.white,
                fg: Colors.black,
              )
            ],
          ),
        ));
  }
}
