

import 'dart:typed_data';

class Place{
  int? seq;
  String name;
  String phone;
  double? lat;
  double? lng;
  Uint8List? image;
  String? estimate;
  DateTime? initDate;

  Place(
    {
      this.seq,
      required this.name,
      required this.phone,
      this.lat,
      this.lng,
      this.image,
      this.estimate,
      this.initDate
    }
  );

  Place.fromJson(Map<String,dynamic> json)
  : seq = json['seq'],
  name = json['name'],
  phone = json['phone'],
  lat = json['lat'],
  lng = json['lng'],
  image = json['image'],
  estimate = json['estimate'],
  initDate = DateTime.parse(json['initDate']);


}