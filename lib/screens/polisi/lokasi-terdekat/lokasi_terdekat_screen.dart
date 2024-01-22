import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/constant.dart';
import "package:http/http.dart" as http;
import 'package:sistem_pelaporan/values/position_utils.dart';

import '../../../values/algorithm_dijkstra.dart';
import '../../../values/output_utils.dart';

class LokasiTerdekatScreen extends StatefulWidget {
  const LokasiTerdekatScreen({super.key});

  @override
  State<LokasiTerdekatScreen> createState() => _LokasiTerdekatScreenState();
}

class _LokasiTerdekatScreenState extends State<LokasiTerdekatScreen> {
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  List<Map<String, dynamic>>? userData;

  var listRoute = [];

  final fs = FirebaseServices();

  var directionSelected = [];
  LatLng? locationSelected;
  LatLng? myLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services are disabled. Please enable the services");
      logO("permission",
          m: "Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied");
        logO("permission", m: "Location permissions are denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(
          "Location permissions are permanently denied, we cannot request permissions.");
      logO("permission",
          m: "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      getDistance(position);
      setState(() {
        myLocation = LatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      logO("e", m: e);
    });

    if (locationSelected != null) positionStream();
  }

  StreamSubscription<Position> positionStream() {
    return Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      if (position != null) {
        setDirectionLine(
            LatLng(position.latitude, position.longitude), locationSelected!);
        setState(() {
          myLocation = LatLng(position.latitude, position.longitude);
        });
      }

      logO("position",
          m: position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  void getDistance(Position position) async {
    try {
      final listUserLoc = await fs.getDataCollection("laporan");

      final List<Map<String, dynamic>> listDatauser = [
        {
          "nama": "admin",
          "jenis_laporan": "",
          "tanggal": "",
          "lokasi": LatLng(position.latitude, position.longitude),
          "jarak": 0.0
        },
      ];

      final listDataFirst = [];

      for (var userData in listUserLoc) {
        listDataFirst.add({
          "nama": userData["nama"],
          "location": userData["lokasi"],
        });
      }

      final result = algorithmDijkstra(position, listDataFirst);

      for (final keyResult in result.keys) {
        for (var userData in listUserLoc) {
          if (result[keyResult]!["latitude"] ==
              userData["lokasi"]["latitude"]) {
            listDatauser.add({
              "nama": keyResult,
              "jenis_laporan": userData["jenis_laporan"],
              "tanggal": userData["tanggal"],
              "lokasi": LatLng(result[keyResult]!["latitude"],
                  result[keyResult]!["longitude"]),
              "jarak": result[keyResult]!["distance"]
            });
          }
        }
      }

      setState(() {
        userData = listDatauser;
      });
    } catch (e) {
      showToast(e);
      logO("e", m: e);
    }
  }

  Future<void> setDirectionLine(LatLng lokasiAwal, LatLng lokasiTujuan) async {
    var url =
        "https://api.tomtom.com/routing/1/calculateRoute/${lokasiAwal.latitude},${lokasiAwal.longitude}:${lokasiTujuan.latitude},${lokasiTujuan.longitude}/json?key=$apiKey&maxAlternatives=0";

    var result = await http.get(Uri.parse(url));
    var res = json.decode(result.body)['routes'];

    var routes = [];

    for (var e in res) {
      var points = e["legs"][0]["points"];
      routes = points;
    }

    setState(() {
      directionSelected = routes;
    });
  }

  // ignore: non_constant_identifier_names
  Marker MarkerComponent(LatLng location, {Color iconColor = Colors.red}) {
    return Marker(
        point: location,
        width: 35,
        height: 35,
        builder: (context) => Icon(
              Icons.location_pin,
              color: iconColor,
              size: 24,
            ),
        anchorPos: AnchorPos.align(AnchorAlign.top));
  }

  @override
  Widget build(BuildContext context) {
    const padding = 50.0;

    logO(myLocation);
    return Scaffold(
        body: userData != null
            ? Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      // center:
                      //     myLocation != null ? myLocation : LatLng(0.0, 0.0),
                      // zoom: 17.0,
                      // bounds: directionSelected.isNotEmpty
                      //     ? LatLngBounds.fromPoints(directionSelected
                      //         .map((e) => LatLng(e["latitude"], e["longitude"]))
                      //         .toList())
                      //     : null,
                      // boundsOptions: FitBoundsOptions(
                      //   padding: EdgeInsets.only(
                      //     left: padding,
                      //     top: padding + MediaQuery.of(context).padding.top,
                      //     right: padding,
                      //     bottom: padding,
                      //   ),
                      // ),

                      bounds: LatLngBounds.fromPoints(userData!
                          .map((uData) => uData["lokasi"] as LatLng)
                          .toList()),
                      boundsOptions: FitBoundsOptions(
                        padding: EdgeInsets.only(
                          left: padding,
                          top: padding + MediaQuery.of(context).padding.top,
                          right: padding,
                          bottom: padding,
                        ),
                      ),
                    ),
                    nonRotatedChildren: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      // MarkerLayer(
                      //     markers: userData!.map((uData) {
                      //   int idx = userData!.indexOf(uData);

                      //   return Marker(
                      //       point: uData["lokasi"],
                      //       width: 35,
                      //       height: 35,
                      //       builder: (context) => Icon(
                      //             Icons.location_pin,
                      //             color: idx == 0 ? Colors.blue : Colors.red,
                      //             size: 24,
                      //           ),
                      //       anchorPos: AnchorPos.align(AnchorAlign.top));
                      // }).toList()),
                      myLocation != null
                          ? MarkerLayer(markers: [
                              MarkerComponent(myLocation!,
                                  iconColor: Colors.blue),
                              locationSelected != null
                                  ? MarkerComponent(locationSelected!,
                                      iconColor: Colors.red)
                                  : MarkerComponent(myLocation!,
                                      iconColor: Colors.blue),
                            ])
                          : const MarkerLayer(),
                      directionSelected.isNotEmpty
                          ? PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: directionSelected
                                      .map((e) =>
                                          LatLng(e["latitude"], e["longitude"]))
                                      .toList(),
                                  strokeJoin: StrokeJoin.round,
                                  borderStrokeWidth: 1,
                                  color: Colors.red,
                                  borderColor: Colors.red,
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: userData != null
                          ? (userData!.length * 40) + (padding * 2)
                          : 0,
                      child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          final value = userData![i];

                          final jarak = value["jarak"] as double;
                          if (i > 0) {
                            return Card(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  LatLng lokasiAwal = userData![0]["lokasi"];
                                  LatLng lokasiTujuan = value["lokasi"];

                                  setDirectionLine(lokasiAwal, lokasiTujuan);

                                  setState(() {
                                    myLocation = lokasiAwal;
                                    locationSelected = lokasiTujuan;
                                  });
                                },
                                child: ListTile(
                                  leading: const CircleAvatar(child: Text("A")),
                                  title: Text(value["nama"]),
                                  subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(value["jenis_laporan"]),
                                        V(8),
                                        TextComponent(
                                            jarak <= 1000
                                                ? "${jarak.toStringAsFixed(2)} m"
                                                : "${(jarak / 1000).toStringAsFixed(2)} km",
                                            size: 16),
                                      ]),
                                  // trailing: Icon(Icons.arrow_right),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                        itemCount: userData?.length,
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
