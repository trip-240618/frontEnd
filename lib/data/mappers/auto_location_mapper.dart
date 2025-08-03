import 'package:tripStory/data/models/response/location_auto_response.dart';
import 'package:tripStory/domain/entities/auto_location_entity.dart';

class AutoLocationMapper {
  static AutoLocationEntity toEntity(LocationAutoResponse response) {
    return AutoLocationEntity(
      placeId: response.placeId,
      address: response.address,
      secondaryAddress: response.secondaryAddress,
    );
  }
}
