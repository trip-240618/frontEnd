import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as cluster;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/permission/permission_state.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';

part 'history_main_state.freezed.dart';

enum HistoryStatus { initial, loading, success, failure }

@freezed
abstract class HistoryMainState with _$HistoryMainState {
  const HistoryMainState._();

  const factory HistoryMainState({
    @Default(0.0) double currentLatitude,
    @Default(0.0) double currentLongitude,
    @Default({}) Set<Marker> markers,
    @Default([]) List<HistoriesEntity> histories,
    @Default(HistoryStatus.initial) HistoryStatus historyStatus,
    OneTimeEvent<bool>? showPhotoPermissionDialog,
  }) = _HistoryMainState;
}

@freezed
abstract class MarkerItem with _$MarkerItem implements cluster.ClusterItem {
  const MarkerItem._();

  const factory MarkerItem({
    required String index,
    required double latitude,
    required double longitude,
    required String thumbnailUrl,
  }) = _MarkerItem;

  @override
  LatLng get location => LatLng(latitude, longitude);

  @override
  String get geohash => '$latitude,$longitude';
}
