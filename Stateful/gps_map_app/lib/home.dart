import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late Position currentPosition;
  late int kindChoice; // Segmented Control의 Index
  late double latData; //= 37.4966633; // latitude
  late double longData; //= 127.06298; // longtitue
  late MapController mapController;
  late bool canRun;
  // late List location;
  double _initLatData = 0;
  double _initLongData = 0;
  final List<Map<String,dynamic>> list = [
    {"latData":37.5878892,"longData":127.0037098,"name":'혜화문','color':Colors.red},
    {"latData":37.5711907,"longData":127.009506,"name":'홍인지문','color':Colors.blue},
    {"latData":37.5926027,"longData":126.9664771,"name":'창의문','color':Colors.green},
    {"latData":37.5956584,"longData":126.9810576,"name":'숙정문','color':Colors.pink},
  ];
  List<Map<String,dynamic>> tmpList = [];

  // Segment Widget
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text(
        '사대문',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11),
      ),
    ),
    1: SizedBox(
      child: Text(
        '돌리뮤지엄',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11),
      ),
    ),
    2: SizedBox(
      width: 120,
      child: Text(
        '서대문형무소역사관',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11),
      ),
    ),
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kindChoice = 0;
    mapController = MapController();
    canRun = false;
    // location = ['사대문', '둘리 뮤지엄', '서대문 형무소 역사관']; // 현재 위치를 클릭하면 어디다 나오는 부분.
    tmpList = list;
    double x=0;
    double y = 0;
    for(var d in list){
      x += d['latData'];
      y += d['longData'];
    };
    _initLatData = x/4;
    _initLongData = y/4;
    checkLocationPermission();
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
      // getCurrentLocation();
      canRun = true;
      setState(() {});
    }
  }

  

  getCurrentLocation() async {
      Position position = await Geolocator.getCurrentPosition();
      currentPosition = position;
      canRun = true;
      latData = currentPosition.latitude;
      longData = currentPosition.longitude;
      return true;

    
  }

  changeMakerToCurrent(double x, double y, String name){
    tmpList = [{"latData":x,"longData":y,"name":name,'color':Colors.red}];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('GPS & MAP'),
              ),
              CupertinoSegmentedControl(
                groupValue: kindChoice,
                children: segmentWidgets,
                onValueChanged: (value) {
                  kindChoice = value;
                  if (kindChoice == 0) {
                    tmpList = list;
                    setState(() {
                      
                    });
                    // latData = currentPosition.latitude;
                    // longData = currentPosition.longitude;
                    mapController.move(latlng.LatLng(_initLatData, _initLongData), 13.0);
                    // changeMakerToCurrent(_initLatData,longData,'4대문');
                  } else if (kindChoice == 1) {
                    latData = 37.65243153;
                    longData = 127.0276397;
                    mapController.move(latlng.LatLng(latData, longData), 17.0);
                     changeMakerToCurrent(latData,longData,'돌리뮤지움');
                  } else {
                    latData = 37.57244171;
                    longData = 126.9595412;
                    mapController.move(latlng.LatLng(latData, longData), 17.0);
                     changeMakerToCurrent(latData,longData,'서대문형무소역사관');
                  }
                 
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
      ),
      floatingActionButton:  FloatingActionButton(
            onPressed: () async {
              canRun = false;
              setState(() {});
              if(await getCurrentLocation()) {

                latData = currentPosition.latitude;
                longData = currentPosition.longitude;
                mapController.move(latlng.LatLng(latData, longData), 17.0);

                changeMakerToCurrent(latData,longData,'현재위치');
                setState(() {});

              }

             
              
            },
            backgroundColor:  Colors.blue,
            foregroundColor: Colors.white,
            child: Icon(Icons.gps_fixed),
      ),
      body: canRun
          ? Center(
            child:Stack(
              children: [
                flutterMap(),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      Text(
                        'abc',
                        style:TextStyle(
                          color:Colors.white
                        )
                      )
                    ],
                  )
                ),
              ] 
              )
          )
          : Center(child: CircularProgressIndicator()),
    );
  }

  // == Functions

  flutterMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latlng.LatLng(
          _initLatData,
          _initLongData,
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
          markers: tmpList.map((d){
            return Marker(
              width: 80,
              height: 80,
              point: latlng.LatLng(d['latData'],d['longData']),
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
