import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/auto_location_entity.dart';

part 'location_search_state.freezed.dart';

@freezed
abstract class LocationSearchState with _$LocationSearchState {
  const LocationSearchState._();

  const factory LocationSearchState({
    @Default([]) List<AutoLocationEntity> searchLocations,
  }) = _LocationSearchState;

  int get searchLocationLength => searchLocations.length;

  String getPlaceName(int index) {
    if (index < 0 || index >= searchLocations.length) return '';

    final address = searchLocations[index].address;
    final secondary = searchLocations[index].secondaryAddress;

    if (secondary == null) return address;

    String reduced = address.replaceAll(secondary, "").trim();
    if (reduced.startsWith(', ')) {
      reduced = reduced.substring(2);
    }

    return reduced;
  }
}
