import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/color_extension.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/scrap_create_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/scrap_create_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/scrap_create_state.dart';

class ScrapCreateController extends GetxController with GetSingleTickerProviderStateMixin {
  final TripRoomService _tripRoomService;
  final ScrapCreateUseCase _scrapCreateUseCase;

  ScrapCreateController(this._tripRoomService, this._scrapCreateUseCase);

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  ScrapCreateState scrapCreateState = ScrapCreateState();

  ScrapCreateState get state => scrapCreateState;

  Future<void> onSavePressed() async {
    scrapCreateState = state.copyWith(
      showLoading: OneTimeEvent(true),
    );
    update();

    final entity = ScrapCreateEntity(
      title: state.title,
      content: state.content,
      hasImage: state.hasImage,
      color: state.color.toJson(),
      photoList: state.photoList,
    );

    final tripId = tripRoomInfo?.id;

    if (tripId == null) return;

    final result = await _scrapCreateUseCase(
      Tuple2(
        tripId,
        entity,
      ),
    );

    result.fold(
      (failure) {
        scrapCreateState = state.copyWith(
          showLoading: OneTimeEvent(false),
        );
      },
      (createdScrap) {
        scrapCreateState = state.copyWith(
          showLoading: OneTimeEvent(false),
        );
      },
    );
    update();
  }
}
