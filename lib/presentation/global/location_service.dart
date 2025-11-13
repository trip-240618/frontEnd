import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;

  LocationService._internal();

  Position? _cachedPosition;

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception("위치 권한이 거부되었습니다.");
      }
    }

    Position? lastKnown = await Geolocator.getLastKnownPosition();

    if (lastKnown != null) {
      _cachedPosition = lastKnown;
      return lastKnown;
    }

    _cachedPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    return _cachedPosition!;
  }
}
