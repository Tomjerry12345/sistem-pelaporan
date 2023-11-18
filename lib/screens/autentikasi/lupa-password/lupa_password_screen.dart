import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

import 'logic.dart';

class LupaPasswordScreen extends StatefulWidget {
  const LupaPasswordScreen({super.key});

  @override
  State<LupaPasswordScreen> createState() => _LupaPasswordScreenState();
}

class _LupaPasswordScreenState extends State<LupaPasswordScreen> {
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
                "Lupa password",
                size: 24,
              ),
              V(16),
              const TextComponent("Silahkan masukkan email terlebih dahulu!",
                  size: 16, weight: FW.light),
              V(48),
              TextfieldComponent(label: "Email", controller: l.email, inputType: TextInputType.emailAddress),
              V(48),
              ButtonElevatedComponent(
                "Reset password",
                onPressed: () {
                  l.onVerifikasi();
                },
                w: 1.0.w,
              ),
              V(24),
            ],
          ),
        ));
  }
}
