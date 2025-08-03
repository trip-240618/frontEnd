import 'package:get/get.dart';
import 'package:tripStory/data/models/request/location_auto_request.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_location_usecase.dart';
import 'package:tripStory/domain/usecases/location_auto_complete_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/location_search_state.dart';

class LocationSearchController extends GetxController {
  final TripRoomService _tripRoomService;
  final PostAutoCompleteUseCase _autoCompleteUseCase;
  final FetchLocationUsecase _fetchLocationUsecase;

  LocationSearchController(
    this._tripRoomService,
    this._autoCompleteUseCase,
    this._fetchLocationUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  LocationSearchState _locationSearchState = LocationSearchState();

  LocationSearchState get state => _locationSearchState;

  Future<void> onSearchLocation(String input) async {
    if (input.trim().isEmpty) {
      _locationSearchState = state.copyWith(
        searchLocations: [],
      );
      update();
      return;
    }

    final request = LocationAutoRequest(
      input: input,
      languageCode: "ko",
      includedRegionCodes: tripRoomInfo?.domain.split(",").toList() ?? [],
    );

    final result = await _autoCompleteUseCase.call(request);

    result.fold(
      (failure) {},
      (locations) {
        _locationSearchState = state.copyWith(
          searchLocations: locations,
        );
        update();
      },
    );
  }

  Future<void> onLocationPressed(
    String placeId,
  ) async {
    final result = await _fetchLocationUsecase.call(placeId);

    result.fold(
      (failure) {},
      (location) {
        Get.back(result: location);
      },
    );
  }
}
