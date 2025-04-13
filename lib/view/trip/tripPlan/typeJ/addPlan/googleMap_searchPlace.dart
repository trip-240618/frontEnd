import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/component/appbar.dart';
import '../../../../../controller/jPlanState.dart';

class GoogleMapSearchPlace extends StatefulWidget {
  const GoogleMapSearchPlace({super.key});

  @override
  State<GoogleMapSearchPlace> createState() => _GoogleMapSearchPlaceState();
}

class _GoogleMapSearchPlaceState extends State<GoogleMapSearchPlace> {
  BitmapDescriptor? customIcon;
  final js = Get.put(JPlanState());
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      _setCustomMarker();
      setState(() {});
    });
  }
  Future<void> _setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/icon/marker.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '여행 등록', onTap: (){Get.back();}),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse('${js.searchLocation[0]['location']['latitude']}'), double.parse('${js.searchLocation[0]['location']['longitude']}')),
                zoom: 14.4746,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('${js.searchLocation[0]['displayName']['text']}'),
                  position: LatLng(double.parse('${js.searchLocation[0]['location']['latitude']}'), double.parse('${js.searchLocation[0]['location']['longitude']}')),
                  onTap: (){
                  },
                  icon: customIcon ?? BitmapDescriptor.defaultMarker,
                )
              },
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                if (!js.mapController.isCompleted) {
                  js.mapController.complete(controller);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
