import 'dart:math' as math;

double getDistance(double lat1, double lon1, double lat2, double lon2) {
  // Mengkonversi derajat ke radian
  double degToRad = math.pi / 180.0;
  lat1 = lat1 * degToRad;
  lon1 = lon1 * degToRad;
  lat2 = lat2 * degToRad;
  lon2 = lon2 * degToRad;

  // Menghitung perbedaan latitude dan longitude
  double dlat = lat2 - lat1;
  double dlon = lon2 - lon1;

  // Menggunakan formula Haversine
  double a = math.pow(math.sin(dlat / 2), 2) +
      math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon / 2), 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double r = 6371; // Radius bumi dalam kilometer

  // Menghitung jarak
  double distance = r * c;
  return distance;
}

List<dynamic> algorithmGreedy(listJalur) {
  // final listJalur = [point1, point2];

  final lastRoute = listJalur[0].last;
  final visited = listJalur[0];
  final pathRoute = [];
  var index = 0;
  var jalurTerpendek = 0;

  for (var _ in listJalur) {
    pathRoute.add(true);
  }

  while (visited.last != lastRoute) {
    final jalurTerpilih = [];
    int next = index + 1;

    for (var i = 0; i < listJalur.length; i++) {
      if (pathRoute[i]) {
        jalurTerpilih.add(i);
      }
    }

    for (var jalur in jalurTerpilih) {
      final lat1 = listJalur[jalur][index]["latitude"];
      final long1 = listJalur[jalur][index]["longitude"];
      final lat2 = listJalur[jalur][next]["latitude"];
      final long2 = listJalur[jalur][next]["longitude"];
      final d = getDistance(lat1!, long1!, lat2!, long2!);
      if (d > jalurTerpendek) {
        jalurTerpendek = jalur;
      }
    }

    final jp = {
      "latitude": listJalur[jalurTerpendek][next]["latitude"],
      "longitude": listJalur[jalurTerpendek][next]["longitude"],
    } as Map<String, double>;

    visited.add(jp);

    for (var jalur in jalurTerpilih) {
      final nextRoute = listJalur[jalur][next];
      if (jp == nextRoute) {
        pathRoute[jalur] = true;
      } else {
        pathRoute[jalur] = false;
      }
    }

    index += 1;
  }

  return visited;
}
