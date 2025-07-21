import 'package:tripStory/data/models/response/location_response.dart';
import 'package:tripStory/domain/entities/location_entity.dart';

class LocationMapper {
  static LocationEntity toEntity(LocationResponse response) {
    return LocationEntity(
      formattedAddress: response.formattedAddress,
      latitude: response.location.latitude,
      longitude: response.location.longitude,
      displayName: response.displayName.text,
    );
  }
}
