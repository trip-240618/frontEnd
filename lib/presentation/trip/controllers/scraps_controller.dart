import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/usecases/delete_scrap_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_scraps_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_scraps_usecase.dart';
import 'package:tripStory/domain/usecases/toggle_scrap_bookmark_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/scraps_state.dart';

class ScrapsController extends GetxController {
  final LoginUserService _userService;
  final TripRoomService _tripRoomService;
  final FetchScrapsUseCase _fetchScrapsUseCase;
  final DeleteScrapUseCase _deleteScrapUseCase;
  final FetchBookmarkedScrapsUseCase _fetchBookmarkedScrapsUseCase;
  final ToggleScrapBookmarkUseCase _toggleScrapBookmarkUseCase;

  ScrapsController(
    this._tripRoomService,
    this._userService,
    this._fetchScrapsUseCase,
    this._deleteScrapUseCase,
    this._fetchBookmarkedScrapsUseCase,
    this._toggleScrapBookmarkUseCase,
  );

  ScrapsState _scrapsState = ScrapsState();

  ScrapsState get state => _scrapsState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  UserEntity? get userInfo => _userService.user;

  @override
  void onInit() {
    super.onInit();
    loadScraps();
  }

  Future<void> loadScraps() async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    final result = await _fetchScrapsUseCase(tripId);
    result.fold(
      (error) {
        _scrapsState = state.copyWith(status: ScrapsStatus.failure);
        update();
      },
      (scrapsResult) {
        _scrapsState = state.copyWith(
            scraps: scrapsResult, status: scrapsResult.isEmpty ? ScrapsStatus.empty : ScrapsStatus.success);
        update();
      },
    );
  }

  Future<void> loadBookmarkedScraps() async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    final result = await _fetchBookmarkedScrapsUseCase(tripId);
    result.fold(
      (error) {
        _scrapsState = state.copyWith(status: ScrapsStatus.failure);
        update();
      },
      (scrapsResult) {
        _scrapsState = state.copyWith(
            scraps: scrapsResult, status: scrapsResult.isEmpty ? ScrapsStatus.empty : ScrapsStatus.success);
        update();
      },
    );
  }

  Future<void> onBookmarkFilterPressed() async {
    if (state.status == ScrapsStatus.loading) {
      return;
    }
    _scrapsState = state.copyWith(isBookmarked: !state.isBookmarked, status: ScrapsStatus.loading);
    update();
    state.isBookmarked ? loadBookmarkedScraps() : loadScraps();
  }

  Future<void> onDeleteScrapPressed(int scrapId) async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    final result = await _deleteScrapUseCase(Tuple2(tripId, scrapId));
    result.fold(
      (error) {},
      (_) {
        Get.back();
        final newList = state.scraps.where((e) => e.id != scrapId).toList();
        _scrapsState = state.copyWith(scraps: newList);
        update();
      },
    );
  }

  Future<void> onBookmarkScrapPressed(int scrapId) async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    final result = await _toggleScrapBookmarkUseCase(Tuple2(tripId, scrapId));
    result.fold(
      (error) {},
      (bookmark) {
        final target = state.findScrap(scrapId);
        if (target == null) return;

        final updated = target.copyWith(bookmark: bookmark);

        _scrapsState = state.copyWith(
          scraps: state.scraps.map((e) => e.id == scrapId ? updated : e).toList(),
        );
        update();
      },
    );
  }

  bool isMine(ScrapEntity scrap) {
    final myUuid = userInfo?.uuid ?? '';
    return scrap.isMine(myUuid);
  }
}
