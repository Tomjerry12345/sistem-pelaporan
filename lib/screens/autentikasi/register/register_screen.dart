import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/avatar/avatar_component.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_dropdown_component.dart';
import 'package:sistem_pelaporan/components/textfield/textfield_password_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

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
        body: SingleChildScrollView(
      child: Padding(
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
            TextComponent(
                "Silahkan registrasi terlebih dahulu untuk melanjutkan",
                size: 16,
                weight: FW.light),
            V(48),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarComponent(
                  "https://www.seekpng.com/png/detail/17-176376_person-free-download-and-person-icon-png.png",
                  // "https://www.seekpng.com/png/detail/17-176376_person-free-download-and-person-icon-png.png",
                  icon: Icons.add_a_photo,
                  colorIconBg: Colors.grey,
                  onGetImage: (image) {
                    l.onPickImage(image, setState);
                  },
                ),
                H(16),
                Column(
                  children: [
                    // Container(
                    //     width: 140,
                    //     child:
                    //     CircleAvatar(
                    //       backgroundImage: AssetImage(
                    //           "assets/images/sample-swafoto-ktp.webp"),
                    //       radius: 60,

                    //     )
                    //     ),
                    ClipOval(
                      child: Container(
                        width: 125,
                        height: 120,
                        color: Colors.green[700],
                        child: Transform.translate(
                          offset: Offset(-3,
                              5), // Sesuaikan offset untuk menyesuaikan posisi gambar
                          child: Image.asset(
                            'assets/images/sample-swafoto-ktp.webp', // Sesuaikan dengan path gambar Anda
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    V(8),
                    TextComponent(
                      "Contoh pengambilan gambar",
                      size: 8,
                    )
                  ],
                )
              ],
            )),
            V(16),
            TextfieldComponent(
              label: "Nama",
              controller: l.nama,
            ),
            V(24),
            TextfieldComponent(
              label: "Email",
              controller: l.email,
              inputType: TextInputType.emailAddress,
            ),
            V(24),
            TextfieldDropdownComponent(
              hintText: "Jenis kelamin",
              controller: l.jenisKelamin,
              items: const [
                {"name": "Laki-laki", "value": "laki-laki"},
                {"name": "Perempuan", "value": "perempuan"}
              ],
            ),
            V(24),
            TextfieldComponent(
              label: "No. Telepon",
              controller: l.noTelepon,
              inputType: TextInputType.phone,
            ),
            V(24),
            TextfieldComponent(
              label: "NIK",
              controller: l.nik,
              inputType: TextInputType.number,
            ),
            V(24),
            TextfieldPasswordComponent(
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
      ),
    ));
  }
}
