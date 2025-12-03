
import 'dart:typed_data';

class Address{
  int? id;
  String name;
  String phone;
  String address;
  String relation;
  Uint8List image;

  Address(
    { 
      this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.relation,
      required this.image,
     }
  );

  Address.fromJson(Map<String,dynamic> json) :
  id = json['id'],
  name = json['name'],
  phone = json['phone'],
  address = json['address'],
  relation = json['relation'],
  image = json['image'];


}