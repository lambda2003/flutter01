import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'package:must_eat_place_app/model/place.dart';
import 'dart:math' as math;

class CheckLocation extends StatefulWidget {
  const CheckLocation({super.key});

  @override
  State<CheckLocation> createState() => _CheckLocationState();
}

class _CheckLocationState extends State<CheckLocation> {
  Place? place = Get.arguments;

  late double lat;
  late double lng;
  late double latData = 0;
  late double longData = 0;
  late String distanceKm = '';
  late MapController mapController;
  // late Position currentPosition;
  bool canRun = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    lat = place!.lat!;
    lng = place!.lng!;
    checkLocationPermission();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }


  
  checkLocationPermission() async {
    // 화면에서 유저에게 permission을 묻는 부분
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 한번 더 물어 본다.
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
        canRun = true;
        setState(() {});
    }
  }

  getCurrentLocation() async {
    // 현재 위치를 얻는다.
    isLoading = true;
    setState(() {});
    Position position = await Geolocator.getCurrentPosition();
    // currentPosition = position;
    isLoading = false;
    latData = position.latitude;
    longData = position.longitude;
   
     mapController.move(LatLng((latData+lat)/2, (longData+lng)/2), 12.0);
    distanceKm = distance(lat,lng,latData,longData).toStringAsFixed(3);
    setState(() {});

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${place!.name} 위치정보'),
        centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getCurrentLocation(), 
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        child: Icon(Icons.gps_fixed,size: 30)
        
      ),
      body: Center(
            child:
            !isLoading? 
            Stack(
              children: [
                flutterMap(),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      latData != 0 ?
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$distanceKm km'),
                        )
                      :  Text('')
                    ],
                  )
                ),
              ] 
              )
              : const CircularProgressIndicator()
          )
    );
  }

  // == Functions
  flutterMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(
          latData==0?lat:latData,
          longData==0?lng:longData,
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
          markers:   latData != 0 ? [
            
            Marker(
              width: 100,
              height: 130,
              point: LatLng(lat,lng),
              child: Column(
                children: [
                 
                      Text(
                        place!.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite,size:13,color:Colors.pink[500]),
                      Text('${place!.likeCount}',style:TextStyle(
                        color: Colors.pink[500],
                        fontSize: 13
                      )),
                    ],
                  ),
                  IconButton(
                    onPressed: ()=>showContentBox(), 
                    icon:  Icon(Icons.pin_drop,size: 50, color:Colors.red),)
                 
                ],
              )
            ),
          
            Marker(
              width: 100,
              height: 130,
              point: LatLng(latData,longData),
              child: 
                 
                  Icon(Icons.my_location_sharp,size: 50, color:Colors.blue)
                 
                
            )
          ]:[
            Marker(
              width: 100,
              height: 130,
              point: LatLng(lat,lng),
              child: Column(
                children: [
                 
                      Text(
                        place!.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite,size:13,color:Colors.pink[500]),
                      Text('${place!.likeCount}',style:TextStyle(
                        color: Colors.pink[500],
                        fontSize: 13
                      )),
                    ],
                  ),
                  IconButton(
                    onPressed: ()=>showContentBox(), 
                    icon:  Icon(Icons.pin_drop,size: 50, color:Colors.red),)
                 
                ],
              )
            ),
          ])
      ],
    );
  }

  // == Functions
  showContentBox(){
    Get.defaultDialog(
      title: '${place!.name}',
      content: Column(
        children: [
          Text('상점이름: ${place!.name}'),
          Text('상점전화: ${place!.phone}'),
          Text('최근평가: ${place!.estimate}'),
        ],
      
      ),
    );

  }

  // 위도와 경도  두곳의 거리 구하기
  distance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // 지구 반지름 (단위: km)
    double dLat = deg2rad(lat2 - lat1);
    double dLon = deg2rad(lon2 - lon1);
    double a = math.sin(dLat/2) * math.sin(dLat/2) +
              math.cos(deg2rad(lat1)) * math.cos(deg2rad(lat2)) *
              math.sin(dLon/2) * math.sin(dLon/2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a));
    double distance = R * c; // 두 지점 간의 거리 (단위: km)
    return distance;
  }

  deg2rad(deg) {
    
    return deg * (math.pi/180);
  }

}