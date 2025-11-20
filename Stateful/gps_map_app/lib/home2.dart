import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {

  // Property
  double x=0;
   double y=0;
  late double latData;
  late double longData;
  late MapController mapController;
  late Position currentPosition;
  late List<Map<String,dynamic>> list = [
    {"latData":37.5878892,"longData":127.0037098,"name":'혜화문','color':Colors.red},
    {"latData":37.5711907,"longData":127.009506,"name":'홍인지문','color':Colors.blue},
    {"latData":37.5926027,"longData":126.9664771,"name":'창의문','color':Colors.green},
    {"latData":37.5956584,"longData":126.9810576,"name":'숙정문','color':Colors.pink},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    checkPermission();
 
    for(var d in list){
      x += d['latData'];
      y += d['longData'];
    };

  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    if(permission == LocationPermission.deniedForever){
      return;
    }

    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){

      getLocation();
    }

  }

  getLocation() async {
    currentPosition = await Geolocator.getCurrentPosition();
    latData = currentPosition.latitude;
    longData = currentPosition.longitude;

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(
          x/4,y/4
        ), // Center the map over London
        initialZoom: 13.0,
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
          markers: list.map((d){
            return Marker(
              width: 80,
              height: 80,
              point: LatLng(d['latData'],d['longData']),
              child: Column(
                children: [
                  Text(
                    d['name'],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.pin_drop,size: 60, color:d['color'])
                ],
              )
            );
            
            
          }).toList()
          
        )
      ],
    );
  }
}

// [
//             Marker(
//               width: 80,
//               height: 80,
//               point: LatLng(37.5878892,127.0037098),
//               child: Column(
//                 children: [
//                   Text(
//                     '혜화문',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Icon(Icons.pin_drop,size: 60, color:Colors.red)
//                 ],
//               )
//             ),
//             Marker(
//               width: 80,
//               height: 80,
//               point: LatLng(37.5711907,127.009506),
//               child: Column(
//                 children: [
//                   Text(
//                     '홍인지문',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Icon(Icons.pin_drop,size: 60, color:Colors.blue)
//                 ],
//               )
//             ),
//             Marker(
//               width: 80,
//               height: 80,
//               point: LatLng(37.5926027,126.9664771),
//               child: Column(
//                 children: [
//                   Text(
//                     '창의문',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Icon(Icons.pin_drop,size: 60, color:Colors.green)
//                 ],
//               )
//             ),
//             Marker(
//               width: 80,
//               height: 80,
//               point: LatLng(37.5956584,126.9810576),
//               child: Column(
//                 children: [
//                   Text(
//                     '숙정문',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Icon(Icons.pin_drop,size: 60, color:Colors.orange)
//                 ],
//               )
//             )
//           ]