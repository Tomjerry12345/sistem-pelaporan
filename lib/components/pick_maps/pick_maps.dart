import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/values/constant.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';

class PickMapsComponent extends StatefulWidget {
  const PickMapsComponent({super.key});

  @override
  State<PickMapsComponent> createState() => _PickMapsComponentState();
}

class _PickMapsComponentState extends State<PickMapsComponent> {
  final MapController _mapController = MapController();
  LatLng? _selectedPosition;

  void _handleTap(TapPosition tapPosition, LatLng latLng) {
    setState(() {
      _selectedPosition = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: latLngDefault, // Pusat peta (latitude dan longitude Jakarta, Indonesia)
            zoom: 13.0, // Tingkat zoom awal
            onTap: _handleTap,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _selectedPosition != null
                  ? [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: _selectedPosition ?? latLngDefault,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ]
                  : [],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonElevatedComponent(
              "Pilih lokasi",
              onPressed: () {
                navigatePop(data: _selectedPosition);
              },
              w: 1.0.w,
            ),
          ),
        )
      ],
    );
  }
}
