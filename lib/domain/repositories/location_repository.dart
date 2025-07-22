import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/location_auto_request.dart';
import 'package:tripStory/domain/entities/auto_location_entity.dart';
import 'package:tripStory/domain/entities/location_entity.dart';

abstract class LocationRepository {
  ResultFuture<List<AutoLocationEntity>> postAutoComplete(LocationAutoRequest request);

  ResultFuture<LocationEntity> fetchPlaceDetail(String placeId);
}
