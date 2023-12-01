import 'dart:math';
import 'package:geolocator/geolocator.dart';

import 'output_utils.dart';

class Point {
  final double latitude;
  final double longitude;

  Point(this.latitude, this.longitude);
}

double algorithmDijkstra(Position positionFirst, List<dynamic> routes) {
  List<Map<String, double>> locationUser = [
    {
      "latitude": positionFirst.latitude,
      "longitude": positionFirst.longitude,
    }
  ];

  // Populate locationUser with route locations
  locationUser.addAll(routes
      .where((route) => route["location"] != null)
      .map((route) => route["location"].cast<String, double>()));

  List<int> posT = [
    0,
  ];
  double totalDistance = 0;

  int pos = 0;

  for (var i = 1; i < locationUser.length; i++) {
    var distances = calculateShortestDistances(locationUser, pos);

    // Find the nearest unvisited location
    var nearest = findNearest(distances, posT);
    // if (i == 2) break;

    // Update the current position and add it to the visited locations
    pos = nearest;
    posT.add(pos);

    // Add the distance to the total distance
    totalDistance += distances[pos]!;
    logO("distances", m: distances);
  }

  // logO("Total Distance: $totalDistance");
  return totalDistance;
}

Map<int, double> calculateShortestDistances(
    List<Map<String, double>> locations, int source) {
  var distances = <int, double>{};

  for (var i = 0; i < locations.length; i++) {
    distances[i] = double.infinity;
  }

  distances[source] = 0;

  for (var i = 0; i < locations.length; i++) {
    for (var j = 0; j < locations.length; j++) {
      if (i != j &&
          locations[j]["latitude"] != null &&
          locations[j]["longitude"] != null) {
        var latUi = locations[i]["latitude"]!;
        var lotUi = locations[i]["longitude"]!;
        var latUj = locations[j]["latitude"]!;
        var lotUj = locations[j]["longitude"]!;

        var jarakpath =
            calculateDistance(Point(latUi, lotUi), Point(latUj, lotUj));

        if (distances[j]! > distances[i]! + jarakpath) {
          distances[j] = (distances[i]! + jarakpath);
        }
      }
    }
  }

  return distances;
}

int findNearest(Map<int, double> distances, List<int> visited) {
  var minValue = double.infinity;
  var minIndex = -1;

  for (var i = 0; i < distances.length; i++) {
    if (!visited.contains(i) && distances[i]! < minValue) {
      minValue = distances[i]!;
      minIndex = i;
    }
  }

  return minIndex;
}

// Rest of your code...

double calculateDistance(Point a, Point b) {
  var earthRadius = 6371; // in kilometers
  var dLat = degreesToRadians(b.latitude - a.latitude);
  var dLon = degreesToRadians(b.longitude - a.longitude);
  var lat1 = degreesToRadians(a.latitude);
  var lat2 = degreesToRadians(b.latitude);

  var haversine =
      pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(haversine), sqrt(1 - haversine));

  return earthRadius * c;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}
