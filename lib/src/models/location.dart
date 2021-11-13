
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final int id;
  final String name;
  final String info;
  final String phone;
  final LatLng position;

  Location(this.id, this.name, this.info,this.phone, this.position);



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}


