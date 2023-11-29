import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/screens/pelapor/pelapor_screen.dart';
import 'package:sistem_pelaporan/screens/polisi/polisi_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

class Logic {
  Logic() {
    onGet();
  }

  Future<void> onGet() async {
    final type = await SharedPreferencesUtils.get(key: "type");

    if (type != "" && type != null) {
      if (type == "polisi") {
        navigatePush(const PolisiScreen(), isRemove: true);
      } else {
        navigatePush(const PelaporScreen(), isRemove: true);
      }
    } else {
      navigatePush(const LoginScreen(), isRemove: true);
    }
  }
}
