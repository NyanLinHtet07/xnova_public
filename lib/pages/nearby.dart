import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
//import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class Nearby extends StatelessWidget {
  const Nearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/xnova_icon.png',
                height: 80,
                width: 80,
              ),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.menu),
                iconSize: 28.0,
                color: Colors.cyan[800],
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 10,
        ),
        body: FlutterMap(
          options: MapOptions(
              initialCenter: LatLng(51.509364, -0.128928), initialZoom: 9.2),
          children: [
            TileLayer(
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
              userAgentPackageName: 'com.example.xnova',
            ),
          ],
        ));
  }
}
