import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../controller/MapState.dart';

class SearchFullMap extends StatefulWidget {
  const SearchFullMap({super.key});

  @override
  State<SearchFullMap> createState() => _SearchFullMapState();
}

class _SearchFullMapState extends State<SearchFullMap> {
  final maps = Get.put(MapState());

  @override
  void initState() {
    maps.addMarkersFullMap();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(maps.latitude.value, maps.longitude.value),
          zoom: 14.4746,
        ),
        markers: maps.selectedMarkers.toSet(),
        onCameraMove: (CameraPosition position){
        },
        onMapCreated: (GoogleMapController controller) {
          if (!maps.mapController.isCompleted) {
            maps.mapController.complete(controller);
          }
        },
      )),
    );
  }
}
