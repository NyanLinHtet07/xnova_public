import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_detail_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
//import 'package:location/location.dart';

class BarDetailMap extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailMap(this.barDetail, {super.key});

  @override
  _BarDetailMapState createState() => _BarDetailMapState();
}

class _BarDetailMapState extends State<BarDetailMap> {
  @override
  Widget build(BuildContext context) {
    final LatLng location =
        LatLng(widget.barDetail.lat ?? 0.0, widget.barDetail.lng ?? 0.0);
    return FlutterMap(
      options: MapOptions(initialCenter: location, initialZoom: 16.2),
      children: [
        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.xnova',
        ),
        MarkerLayer(
          markers: [
            Marker(
                point: location,
                child: Builder(
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                    color: Colors.cyan,
                    size: 40.0,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
