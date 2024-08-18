import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JPlanState extends GetxController{
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isGoogleExpanded = true.obs;
  final isSorting = false.obs;

  @override
  void onInit() {
    latitude.value = 36.35475233611197;
    longitude.value = 127.34170655688537;
    super.onInit();
  }
  @override
  void dispose() {
    isGoogleExpanded.value = true;
    super.dispose();
  }
}