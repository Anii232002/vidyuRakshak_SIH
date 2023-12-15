import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  static final List<Marker> markerList = [
    Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(17.1707, 74.6869),
        infoWindow:
            const InfoWindow(title: 'Corridor 1', snippet: 'Medium priority'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
    const Marker(
        markerId: MarkerId('marker2'),
        position: LatLng(17.17120102428499, 74.68727979809046),
        infoWindow: InfoWindow(title: 'Corridor 5')),
  ];
}
