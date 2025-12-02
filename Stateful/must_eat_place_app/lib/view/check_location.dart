import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'package:must_eat_place_app/model/place.dart';

class CheckLocation extends StatefulWidget {
  const CheckLocation({super.key});

  @override
  State<CheckLocation> createState() => _CheckLocationState();
}

class _CheckLocationState extends State<CheckLocation> {
  Place? place = Get.arguments;

  late double lat;
  late double lng;
  late MapController mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    lat = place!.lat!;
    lng = place!.lng!;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${place!.name} 위치정보'),
        centerTitle: true,
      ),
      body: Center(
            child:Stack(
              children: [
                flutterMap(),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Text('abc')
                    ],
                  )
                ),
              ] 
              )
          )
    );
  }

  // == Functions
  flutterMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(
          lat,
          lng,
        ), // Center the map over London
        initialZoom: 17.0,
      ),
      children: [
        TileLayer(
          // Bring your own tiles
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
          userAgentPackageName: 'GPS_MAP_APP', // Add your app identifier
          // And many more recommended properties!
        ),
        RichAttributionWidget(
          // Include a stylish prebuilt attribution widget that meets all requirments
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap',
              onTap: () => (Uri.parse(
                'https://openstreetmap.org/copyright',
              )), // (external)
            ),
            // Also add images...
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: LatLng(lat,lng),
              child: Column(
                children: [
                  Text(
                    place!.name,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.pin_drop,size: 60, color:Colors.red)
                ],
              )
            )
          ])
      ],
    );
  }

}