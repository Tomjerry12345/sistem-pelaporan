import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/polisi/histori/histori_polisi_screen.dart';
import 'package:sistem_pelaporan/screens/polisi/laporan/laporan_screen.dart';
import 'package:sistem_pelaporan/screens/polisi/lokasi-terdekat/lokasi_terdekat_screen.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextComponent(
                "polisi",
                size: 18,
                weight: FW.light,
              ),
              V(8),
              const TextComponent("Dashboard"),
              V(48),
              Column(
                children: [
                  SizedBox(
                      width: 0.8.w,
                      child: Image.asset("assets/images/bg_splash.png")),
                  V(48),
                  ButtonElevatedComponent(
                    "Laporan",
                    onPressed: () {
                      navigatePush(const LaporanScreen());
                    },
                    w: 0.6.w,
                  ),
                  V(16),
                  ButtonElevatedComponent(
                    "Lokasi kejadian terdekat",
                    onPressed: () {
                      navigatePush(const LokasiTerdekatScreen());
                    },
                    w: 0.6.w,
                  ),
                  V(16),
                  ButtonElevatedComponent(
                    "Histori",
                    onPressed: () {
                      navigatePush(const HistoriPolisiScreen());
                    },
                    w: 0.6.w,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
