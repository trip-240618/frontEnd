// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_rooms_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomsState {
  List<TripRoomEntity> get tripRooms;
  TripRoomType get tripRoomType;

  /// Create a copy of TripRoomsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomsStateCopyWith<TripRoomsState> get copyWith =>
      _$TripRoomsStateCopyWithImpl<TripRoomsState>(
          this as TripRoomsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomsState &&
            const DeepCollectionEquality().equals(other.tripRooms, tripRooms) &&
            (identical(other.tripRoomType, tripRoomType) ||
                other.tripRoomType == tripRoomType));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(tripRooms), tripRoomType);

  @override
  String toString() {
    return 'TripRoomsState(tripRooms: $tripRooms, tripRoomType: $tripRoomType)';
  }
}

/// @nodoc
abstract mixin class $TripRoomsStateCopyWith<$Res> {
  factory $TripRoomsStateCopyWith(
          TripRoomsState value, $Res Function(TripRoomsState) _then) =
      _$TripRoomsStateCopyWithImpl;
  @useResult
  $Res call({List<TripRoomEntity> tripRooms, TripRoomType tripRoomType});
}

/// @nodoc
class _$TripRoomsStateCopyWithImpl<$Res>
    implements $TripRoomsStateCopyWith<$Res> {
  _$TripRoomsStateCopyWithImpl(this._self, this._then);

  final TripRoomsState _self;
  final $Res Function(TripRoomsState) _then;

  /// Create a copy of TripRoomsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripRooms = null,
    Object? tripRoomType = null,
  }) {
    return _then(_self.copyWith(
      tripRooms: null == tripRooms
          ? _self.tripRooms
          : tripRooms // ignore: cast_nullable_to_non_nullable
              as List<TripRoomEntity>,
      tripRoomType: null == tripRoomType
          ? _self.tripRoomType
          : tripRoomType // ignore: cast_nullable_to_non_nullable
              as TripRoomType,
    ));
  }
}

/// @nodoc

class _TripRoomsState extends TripRoomsState {
  const _TripRoomsState(
      {final List<TripRoomEntity> tripRooms = const [],
      this.tripRoomType = TripRoomType.coming})
      : _tripRooms = tripRooms,
        super._();

  final List<TripRoomEntity> _tripRooms;
  @override
  @JsonKey()
  List<TripRoomEntity> get tripRooms {
    if (_tripRooms is EqualUnmodifiableListView) return _tripRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tripRooms);
  }

  @override
  @JsonKey()
  final TripRoomType tripRoomType;

  /// Create a copy of TripRoomsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomsStateCopyWith<_TripRoomsState> get copyWith =>
      __$TripRoomsStateCopyWithImpl<_TripRoomsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomsState &&
            const DeepCollectionEquality()
                .equals(other._tripRooms, _tripRooms) &&
            (identical(other.tripRoomType, tripRoomType) ||
                other.tripRoomType == tripRoomType));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_tripRooms), tripRoomType);

  @override
  String toString() {
    return 'TripRoomsState(tripRooms: $tripRooms, tripRoomType: $tripRoomType)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomsStateCopyWith<$Res>
    implements $TripRoomsStateCopyWith<$Res> {
  factory _$TripRoomsStateCopyWith(
          _TripRoomsState value, $Res Function(_TripRoomsState) _then) =
      __$TripRoomsStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<TripRoomEntity> tripRooms, TripRoomType tripRoomType});
}

/// @nodoc
class __$TripRoomsStateCopyWithImpl<$Res>
    implements _$TripRoomsStateCopyWith<$Res> {
  __$TripRoomsStateCopyWithImpl(this._self, this._then);

  final _TripRoomsState _self;
  final $Res Function(_TripRoomsState) _then;

  /// Create a copy of TripRoomsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripRooms = null,
    Object? tripRoomType = null,
  }) {
    return _then(_TripRoomsState(
      tripRooms: null == tripRooms
          ? _self._tripRooms
          : tripRooms // ignore: cast_nullable_to_non_nullable
              as List<TripRoomEntity>,
      tripRoomType: null == tripRoomType
          ? _self.tripRoomType
          : tripRoomType // ignore: cast_nullable_to_non_nullable
              as TripRoomType,
    ));
  }
}

// dart format on
