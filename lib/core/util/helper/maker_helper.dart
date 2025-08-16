import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerHelper {
  static final Map<String, BitmapDescriptor> _cache = {};

  static Future<BitmapDescriptor> loadCustomMarker(String assetPath) async {
    if (_cache.containsKey(assetPath)) return _cache[assetPath]!;

    final icon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      assetPath,
    );
    _cache[assetPath] = icon;
    return icon;
  }

  static Marker createMarker({
    required String id,
    required LatLng position,
    required BitmapDescriptor icon,
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      onTap: onTap,
    );
  }
}
