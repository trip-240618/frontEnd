import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String formattedAddress;
  final double latitude;
  final double longitude;
  final String displayName;

  const LocationEntity({
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
    required this.displayName,
  });

  @override
  List<Object> get props => [
        formattedAddress,
        latitude,
        longitude,
        displayName,
      ];
}
