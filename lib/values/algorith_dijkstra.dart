import 'dart:math';

import 'output_utils.dart';

class Point {
  final double latitude;
  final double longitude;

  Point(this.latitude, this.longitude);
}

class Dijkstra {
  final List<Point> nodes;
  final Map<Point, Map<Point, double>> edges;
  late final Map<Point, Point?> previous;

  Dijkstra(this.nodes, this.edges) {
    previous =
        Map<Point, Point?>.fromIterables(nodes, List.generate(nodes.length, (index) => null));
  }

  Map<Point, double> findShortestPath(Point start) {
    var distances = <Point, double>{};

    nodes.forEach((node) {
      distances[node] = double.infinity;
    });

    distances[start] = 0;

    var unvisitedNodes = List.from(nodes);

    while (unvisitedNodes.isNotEmpty) {
      unvisitedNodes.sort((a, b) => distances[a]!.compareTo(distances[b]!));
      var closest = unvisitedNodes.removeAt(0);

      if (distances[closest] == double.infinity) {
        break;
      }

      for (var neighbor in edges[closest]!.keys) {
        var distance = distances[closest]! + edges[closest]![neighbor]!;
        if (distance < distances[neighbor]!) {
          distances[neighbor] = distance;
          previous[neighbor] = closest;
        }
      }
    }

    return distances;
  }

  List<Point> shortestPath(Point start, Point end) {
    var distances = findShortestPath(start);
    var path = <Point>[];
    Point? current = end;

    while (current != null) {
      path.insert(0, current);
      current = previous[current];
    }

    return path;
  }
}

double algorithmDijkstra(routes) {
  double distance = 0;
  for (final route in routes) {
    var edges = <Point, Map<Point, double>>{};
    List<Point> point = [];

    for (final r in route) {
      point.add(Point(r["latitude"], r["longitude"]));
    }

    // Fill in the edges map with distances between points
    for (var i = 0; i < point.length; i++) {
      edges[point[i]] = {};

      for (var j = 0; j < point.length; j++) {
        if (i != j) {
          var distance = calculateDistance(point[i], point[j]);
          edges[point[i]]![point[j]] = distance;
        }
      }
    }

    var dijkstra = Dijkstra(point, edges);

    var start = point[0];
    var end = point[point.length - 1];

    var shortestDistance = dijkstra.findShortestPath(start)[end];
    // var shortestPath = dijkstra.shortestPath(start, end);

    logO("Shortest Distance", m: shortestDistance);

    distance = shortestDistance!;
    // logO('Shortest Path:');
    // shortestPath.forEach((point) {
    //   logO('Latitude: ${point.latitude}, Longitude: ${point.longitude}');
    // });
  }

  return distance;
}

double calculateDistance(Point a, Point b) {
  var earthRadius = 6371; // in kilometers
  var dLat = degreesToRadians(b.latitude - a.latitude);
  var dLon = degreesToRadians(b.longitude - a.longitude);
  var lat1 = degreesToRadians(a.latitude);
  var lat2 = degreesToRadians(b.latitude);

  var haversine = pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(haversine), sqrt(1 - haversine));

  return earthRadius * c;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}
