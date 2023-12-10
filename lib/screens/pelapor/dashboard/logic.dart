import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:sistem_pelaporan/screens/pelapor/histori/histori_pelapor_screen.dart';
import 'package:sistem_pelaporan/screens/pelapor/laporan/tambah/tambah_laporan_screen.dart';
import 'package:sistem_pelaporan/screens/pelapor/titik_rawan/titik_rawan_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

class Logic {
  // final sharedPreferencesUtils = SharedPreferencesUtils();

  String nama = "";

  Logic() {
    requestPermission();
  }

  Future<void> onGet(void Function(VoidCallback fn) setState) async {
    final nama = await SharedPreferencesUtils.get(key: "nama");
    setState(() {
      this.nama = nama;
    });
  }

  Future<void> requestPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permissions.
    }
  }

  void onMoveLaporan() {
    navigatePush(const TambahLaporanScreen());
  }

  void onMoveTitikRawan() {
    navigatePush(const TitikRawanScreen());
  }

  void onMoveHistori() {
    navigatePush(const HistoriPelaporScreen());
  }
}
