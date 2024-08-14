import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/controller/historyState.dart';

class TripHistoryMainPage extends StatefulWidget {
  const TripHistoryMainPage({super.key});

  @override
  State<TripHistoryMainPage> createState() => _TripHistoryMainPageState();
}

class _TripHistoryMainPageState extends State<TripHistoryMainPage> {
  final hs = Get.put(HistoryState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(hs.latitude.value, hs.longitude.value),
                zoom: 14.4746,
              ),
              markers:  {
                Marker(
                    markerId: MarkerId('Sydney'),
                    position: LatLng(hs.latitude.value, hs.longitude.value),
                    onTap: (){}
                )
              },
              onMapCreated: (GoogleMapController controller) {
                if(!hs.mapController.isCompleted){
                  hs.mapController.complete(controller);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
