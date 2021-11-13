import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:juniors_on_map/src/models/location.dart';
import 'package:provider/provider.dart';

class MapProvider with ChangeNotifier{
  static  final List<Location> _kLocations = [
    Location(0, "PenBook Juniors", "Education in Sanaa, Yemen","777 777 777", const LatLng(15.333315349052969, 44.19993043486555)),
    Location(1, "Best Juniors", "Education in Sanaa, Yemen","733 333 333", const LatLng(15.335395179188186, 44.19792023932672)),
    Location(2, "AL-Rsheed",    "no description","711 111 111", const LatLng(15.332537172139642, 44.19655733705683)),
    Location(3, "Juniors no.4", "no description","774 347 647", const LatLng(15.335105467822364, 44.19953492904383)),
    Location(4, "Juniors no.5", "no description","700 000 000", const LatLng(15.336912784984639, 44.19616050202051)),
  ];

  Location? _currentLocation;
  MapType _mapType = MapType.terrain;


  MapType get mapType => _mapType;

  set mapType(MapType value) {
    _mapType = value;
    notifyListeners();
  }

  void get changMapType{
    const list =MapType.values;
    final value = list[(_mapType.index + 1)%list.length];
    mapType = value;
  }

  Location? get currentLocation => _currentLocation;


  set currentLocation(Location? value) {
    _currentLocation = value;
    notifyListeners();
  }

  List<Marker> getLocations() {
    return _kLocations.map((e) {
      return Marker(
        markerId: MarkerId(e.name),
        position: e.position,
        infoWindow: InfoWindow(title: e.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(currentLocation?.id == e.id ?BitmapDescriptor.hueAzure:BitmapDescriptor.hueRed ),
        onTap: () {
          currentLocation = e;
          notifyListeners();
        },
      );
      
    }).toList();

  }

}