// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_room_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomCreateState {
  XFile? get roomImage;
  String get title;
  TripColor get selectedColor;
  TripType? get type;
  List<DateTime> get tripDate;
  String get tripDestination;
  OneTimeEvent<bool>? get showTripSearchBottomSheet;
  OneTimeEvent<bool>? get showLoading;
  OneTimeEvent<String>? get showCodeDialog;

  /// Create a copy of TripRoomCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomCreateStateCopyWith<TripRoomCreateState> get copyWith =>
      _$TripRoomCreateStateCopyWithImpl<TripRoomCreateState>(
          this as TripRoomCreateState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomCreateState &&
            (identical(other.roomImage, roomImage) ||
                other.roomImage == roomImage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.tripDate, tripDate) &&
            (identical(other.tripDestination, tripDestination) ||
                other.tripDestination == tripDestination) &&
            (identical(other.showTripSearchBottomSheet,
                    showTripSearchBottomSheet) ||
                other.showTripSearchBottomSheet == showTripSearchBottomSheet) &&
            (identical(other.showLoading, showLoading) ||
                other.showLoading == showLoading) &&
            (identical(other.showCodeDialog, showCodeDialog) ||
                other.showCodeDialog == showCodeDialog));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomImage,
      title,
      selectedColor,
      type,
      const DeepCollectionEquality().hash(tripDate),
      tripDestination,
      showTripSearchBottomSheet,
      showLoading,
      showCodeDialog);

  @override
  String toString() {
    return 'TripRoomCreateState(roomImage: $roomImage, title: $title, selectedColor: $selectedColor, type: $type, tripDate: $tripDate, tripDestination: $tripDestination, showTripSearchBottomSheet: $showTripSearchBottomSheet, showLoading: $showLoading, showCodeDialog: $showCodeDialog)';
  }
}

/// @nodoc
abstract mixin class $TripRoomCreateStateCopyWith<$Res> {
  factory $TripRoomCreateStateCopyWith(
          TripRoomCreateState value, $Res Function(TripRoomCreateState) _then) =
      _$TripRoomCreateStateCopyWithImpl;
  @useResult
  $Res call(
      {XFile? roomImage,
      String title,
      TripColor selectedColor,
      TripType? type,
      List<DateTime> tripDate,
      String tripDestination,
      OneTimeEvent<bool>? showTripSearchBottomSheet,
      OneTimeEvent<bool>? showLoading,
      OneTimeEvent<String>? showCodeDialog});
}

/// @nodoc
class _$TripRoomCreateStateCopyWithImpl<$Res>
    implements $TripRoomCreateStateCopyWith<$Res> {
  _$TripRoomCreateStateCopyWithImpl(this._self, this._then);

  final TripRoomCreateState _self;
  final $Res Function(TripRoomCreateState) _then;

  /// Create a copy of TripRoomCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomImage = freezed,
    Object? title = null,
    Object? selectedColor = null,
    Object? type = freezed,
    Object? tripDate = null,
    Object? tripDestination = null,
    Object? showTripSearchBottomSheet = freezed,
    Object? showLoading = freezed,
    Object? showCodeDialog = freezed,
  }) {
    return _then(_self.copyWith(
      roomImage: freezed == roomImage
          ? _self.roomImage
          : roomImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      selectedColor: null == selectedColor
          ? _self.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as TripColor,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as TripType?,
      tripDate: null == tripDate
          ? _self.tripDate
          : tripDate // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      tripDestination: null == tripDestination
          ? _self.tripDestination
          : tripDestination // ignore: cast_nullable_to_non_nullable
              as String,
      showTripSearchBottomSheet: freezed == showTripSearchBottomSheet
          ? _self.showTripSearchBottomSheet
          : showTripSearchBottomSheet // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<bool>?,
      showLoading: freezed == showLoading
          ? _self.showLoading
          : showLoading // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<bool>?,
      showCodeDialog: freezed == showCodeDialog
          ? _self.showCodeDialog
          : showCodeDialog // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<String>?,
    ));
  }
}

/// @nodoc

class _TripRoomCreateState extends TripRoomCreateState {
  const _TripRoomCreateState(
      {this.roomImage,
      this.title = "",
      this.selectedColor = TripColor.pastelBlue,
      this.type,
      final List<DateTime> tripDate = const [],
      this.tripDestination = "",
      this.showTripSearchBottomSheet,
      this.showLoading,
      this.showCodeDialog})
      : _tripDate = tripDate,
        super._();

  @override
  final XFile? roomImage;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final TripColor selectedColor;
  @override
  final TripType? type;
  final List<DateTime> _tripDate;
  @override
  @JsonKey()
  List<DateTime> get tripDate {
    if (_tripDate is EqualUnmodifiableListView) return _tripDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tripDate);
  }

  @override
  @JsonKey()
  final String tripDestination;
  @override
  final OneTimeEvent<bool>? showTripSearchBottomSheet;
  @override
  final OneTimeEvent<bool>? showLoading;
  @override
  final OneTimeEvent<String>? showCodeDialog;

  /// Create a copy of TripRoomCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomCreateStateCopyWith<_TripRoomCreateState> get copyWith =>
      __$TripRoomCreateStateCopyWithImpl<_TripRoomCreateState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomCreateState &&
            (identical(other.roomImage, roomImage) ||
                other.roomImage == roomImage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._tripDate, _tripDate) &&
            (identical(other.tripDestination, tripDestination) ||
                other.tripDestination == tripDestination) &&
            (identical(other.showTripSearchBottomSheet,
                    showTripSearchBottomSheet) ||
                other.showTripSearchBottomSheet == showTripSearchBottomSheet) &&
            (identical(other.showLoading, showLoading) ||
                other.showLoading == showLoading) &&
            (identical(other.showCodeDialog, showCodeDialog) ||
                other.showCodeDialog == showCodeDialog));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomImage,
      title,
      selectedColor,
      type,
      const DeepCollectionEquality().hash(_tripDate),
      tripDestination,
      showTripSearchBottomSheet,
      showLoading,
      showCodeDialog);

  @override
  String toString() {
    return 'TripRoomCreateState(roomImage: $roomImage, title: $title, selectedColor: $selectedColor, type: $type, tripDate: $tripDate, tripDestination: $tripDestination, showTripSearchBottomSheet: $showTripSearchBottomSheet, showLoading: $showLoading, showCodeDialog: $showCodeDialog)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomCreateStateCopyWith<$Res>
    implements $TripRoomCreateStateCopyWith<$Res> {
  factory _$TripRoomCreateStateCopyWith(_TripRoomCreateState value,
          $Res Function(_TripRoomCreateState) _then) =
      __$TripRoomCreateStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {XFile? roomImage,
      String title,
      TripColor selectedColor,
      TripType? type,
      List<DateTime> tripDate,
      String tripDestination,
      OneTimeEvent<bool>? showTripSearchBottomSheet,
      OneTimeEvent<bool>? showLoading,
      OneTimeEvent<String>? showCodeDialog});
}

/// @nodoc
class __$TripRoomCreateStateCopyWithImpl<$Res>
    implements _$TripRoomCreateStateCopyWith<$Res> {
  __$TripRoomCreateStateCopyWithImpl(this._self, this._then);

  final _TripRoomCreateState _self;
  final $Res Function(_TripRoomCreateState) _then;

  /// Create a copy of TripRoomCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? roomImage = freezed,
    Object? title = null,
    Object? selectedColor = null,
    Object? type = freezed,
    Object? tripDate = null,
    Object? tripDestination = null,
    Object? showTripSearchBottomSheet = freezed,
    Object? showLoading = freezed,
    Object? showCodeDialog = freezed,
  }) {
    return _then(_TripRoomCreateState(
      roomImage: freezed == roomImage
          ? _self.roomImage
          : roomImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      selectedColor: null == selectedColor
          ? _self.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as TripColor,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as TripType?,
      tripDate: null == tripDate
          ? _self._tripDate
          : tripDate // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      tripDestination: null == tripDestination
          ? _self.tripDestination
          : tripDestination // ignore: cast_nullable_to_non_nullable
              as String,
      showTripSearchBottomSheet: freezed == showTripSearchBottomSheet
          ? _self.showTripSearchBottomSheet
          : showTripSearchBottomSheet // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<bool>?,
      showLoading: freezed == showLoading
          ? _self.showLoading
          : showLoading // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<bool>?,
      showCodeDialog: freezed == showCodeDialog
          ? _self.showCodeDialog
          : showCodeDialog // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<String>?,
    ));
  }
}

// dart format on
