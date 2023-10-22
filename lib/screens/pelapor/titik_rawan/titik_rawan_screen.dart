import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';

class TitikRawanScreen extends StatefulWidget {
  const TitikRawanScreen({super.key});

  @override
  State<TitikRawanScreen> createState() => _TitikRawanScreenState();
}

class _TitikRawanScreenState extends State<TitikRawanScreen> {
  final fs = FirebaseServices();

  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  LatLng? centerMaps;

  var listRoute = [];

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
      logO("permission", m: "Location services are disabled. Please enable the services");
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
      showToast("Location permissions are permanently denied, we cannot request permissions.");
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
    }).catchError((e) {
      logO("e", m: e);
    });
    positionStream();
  }

  StreamSubscription<Position> positionStream() {
    return Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      if (position != null) {
        setState(() {
          centerMaps = LatLng(position.latitude, position.longitude);
        });
      }

      logO("position",
          m: position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  void getDistance(Position position) async {
    setState(() {
      centerMaps = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: centerMaps != null
            ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: fs.getDataQueryStream("laporan", "type", "keluar"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.docs;

                    return Stack(
                      children: [
                        FlutterMap(
                          // options: MapOptions(
                          //   bounds: LatLngBounds.fromPoints(coordinates!
                          //       .map((location) => LatLng(location.latitude, location.longitude))
                          //       .toList()),
                          //   boundsOptions: FitBoundsOptions(
                          //     padding: EdgeInsets.only(
                          //       left: padding,
                          //       top: padding + MediaQuery.of(context).padding.top,
                          //       right: padding,
                          //       bottom: padding,
                          //     ),
                          //   ),
                          // ),
                          options: MapOptions(
                            center:
                                centerMaps, // Pusat peta (latitude dan longitude Jakarta, Indonesia)
                            zoom: 13.0, // Tingkat zoom awal
                          ),
                          nonRotatedChildren: [
                            TileLayer(
                                // urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                                //     "{z}/{x}/{y}.png?key=$apiKey",
                                // additionalOptions: const {"apiKey": apiKey}
                                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']),
                            MarkerLayer(
                                markers: data.map((d) {
                              return Marker(
                                  point: LatLng(d["lokasi"]["latitude"], d["lokasi"]["longitude"]),
                                  width: 35,
                                  height: 35,
                                  builder: (context) => Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                  anchorPos: AnchorPos.align(AnchorAlign.top));
                            }).toList()),
                            // PolylineLayer(
                            //   polylines: [
                            //     Polyline(
                            //       points: listRoute
                            //           .map((e) => LatLng(2, 2))
                            //           .toList(),
                            //       strokeJoin: StrokeJoin.round,
                            //       borderStrokeWidth: _defaultStrokeWidth,
                            //       color: _defaultColor,
                            //       borderColor: _defaultColor,
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        //     margin: const EdgeInsets.only(bottom: 20),
                        //     decoration: BoxDecoration(
                        //         color: Colors.white, borderRadius: BorderRadius.circular(40)),
                        //     child: Text(_message),
                        //   ),
                        // )
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
