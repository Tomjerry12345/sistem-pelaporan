import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/button/link_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_password_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/register/register_screen.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

import 'logic.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                "Login",
                size: 24,
              ),
              V(16),
              const TextComponent(
                  "Silahkan login terlebih dahulu untuk melanjutkan",
                  size: 16,
                  weight: FW.light),
              V(48),
              TextfieldComponent(
                  label: "NIK",
                  controller: l.nik,
                  inputType: TextInputType.number),
              V(24),
              TextfieldPasswordComponent(
                label: "Password",
                controller: l.password,
              ),
              V(24),
              LinkComponent(
                "Lupa password?",
                onTap: () {
                  l.onLupaPassword();
                },
              ),
              V(48),
              ButtonElevatedComponent(
                "Login",
                onPressed: () {
                  l.onLogin();
                },
                w: 1.0.w,
              ),
              V(24),
              ButtonElevatedComponent(
                "Register",
                onPressed: () {
                  navigatePush(const RegisterScreen());
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
