import 'dart:math';

class Node {
  final String name;
  final double latitude;
  final double longitude;

  Node(this.name, this.latitude, this.longitude);

  @override
  String toString() {
    return "Node: $name => $latitude => $longitude";
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class Graph {
  final List<Node> nodes;
  final Map<Node, Map<Node, double>> _adjacencyMap;

  Graph(this.nodes) : _adjacencyMap = {} {
    // Inisialisasi map adjacency untuk setiap node
    for (final node in nodes) {
      _adjacencyMap[node] = {};
    }
    // Bangun adjacency map berdasarkan jarak euclidean antar node
    for (final node1 in nodes) {
      for (final node2 in nodes) {
        if (node1 != node2) {
          final distance = calculateDistance(node1, node2);
          _adjacencyMap[node1]![node2] = distance;
        }
      }
    }
  }

  double calculateDistance(Node node1, Node node2) {
    // Hitung jarak Euclidean antara dua node berdasarkan koordinat mereka
    final dx = node1.latitude - node2.latitude;
    final dy = node1.longitude - node2.longitude;
    return sqrt(dx * dx + dy * dy);
  }

  List<Node> shortestPath(Node startNode) {
    final Map<Node, double> distances = {};
    final Map<Node, Node?> previousNodes = {};
    final List<Node> unvisited = List.from(nodes);

    // Inisialisasi jarak dari startNode ke setiap node lainnya dengan nilai tak terhingga
    for (final node in nodes) {
      distances[node] = double.infinity;
    }
    distances[startNode] = 0;

    while (unvisited.isNotEmpty) {
      unvisited.sort((a, b) => distances[a]!.compareTo(distances[b]!));
      final currentNode = unvisited.removeAt(0);

      for (final neighbor in _adjacencyMap[currentNode]!.keys) {
        final alt =
            distances[currentNode]! + _adjacencyMap[currentNode]![neighbor]!;
        if (alt < distances[neighbor]!) {
          distances[neighbor] = alt;
          previousNodes[neighbor] = currentNode;
        }
      }
    }

    return getPath(previousNodes, startNode);
  }

  List<Node> getPath(Map<Node, Node?> previousNodes, Node startNode) {
    final List<Node> path = [];
    Node? currentNode = previousNodes.keys.firstWhereOrNull(
        (key) => previousNodes[key] == null && key != startNode);
    while (currentNode != null) {
      path.add(currentNode);
      currentNode = previousNodes[currentNode];
    }
    return path.reversed.toList();
  }
}

void main() {
  List<Node> nodes = [
    Node("test", -5.2037724, 119.4943586),
    Node("test-1", -5.1555084, 119.4367169),
    Node("test-2", -5.1672777, 119.4765892),
  ];

  Graph graph = Graph(nodes);

  Node startNode = nodes[0];
  List<Node> shortestPath = graph.shortestPath(startNode);

  print('Shortest Path from ${startNode.name} to other nodes:');
  for (final node in shortestPath) {
    print('${node.name}');
  }
}
