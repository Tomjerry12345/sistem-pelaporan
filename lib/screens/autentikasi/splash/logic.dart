import 'package:sistem_pelaporan/screens/pelapor/pelapor_screen.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

class Logic {
  final sharedPreferencesUtils = SharedPreferencesUtils();

  Logic() {
    onGet();
  }

  Future<void> onGet() async {
    final nama = await sharedPreferencesUtils.get(type: "string", key: "nama");
    logO("test", m: nama);
    if (nama != null) {
      navigatePush(const PelaporScreen(), isRemove: true);
    }
  }
}
