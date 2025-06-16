// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_room_create_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomCreateResponse {
  int get tripId;
  String get invitationCode;

  /// Create a copy of TripRoomCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomCreateResponseCopyWith<TripRoomCreateResponse> get copyWith =>
      _$TripRoomCreateResponseCopyWithImpl<TripRoomCreateResponse>(
          this as TripRoomCreateResponse, _$identity);

  /// Serializes this TripRoomCreateResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomCreateResponse &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.invitationCode, invitationCode) ||
                other.invitationCode == invitationCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tripId, invitationCode);

  @override
  String toString() {
    return 'TripRoomCreateResponse(tripId: $tripId, invitationCode: $invitationCode)';
  }
}

/// @nodoc
abstract mixin class $TripRoomCreateResponseCopyWith<$Res> {
  factory $TripRoomCreateResponseCopyWith(TripRoomCreateResponse value,
          $Res Function(TripRoomCreateResponse) _then) =
      _$TripRoomCreateResponseCopyWithImpl;
  @useResult
  $Res call({int tripId, String invitationCode});
}

/// @nodoc
class _$TripRoomCreateResponseCopyWithImpl<$Res>
    implements $TripRoomCreateResponseCopyWith<$Res> {
  _$TripRoomCreateResponseCopyWithImpl(this._self, this._then);

  final TripRoomCreateResponse _self;
  final $Res Function(TripRoomCreateResponse) _then;

  /// Create a copy of TripRoomCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? invitationCode = null,
  }) {
    return _then(_self.copyWith(
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      invitationCode: null == invitationCode
          ? _self.invitationCode
          : invitationCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TripRoomCreateResponse implements TripRoomCreateResponse {
  const _TripRoomCreateResponse(
      {required this.tripId, required this.invitationCode});
  factory _TripRoomCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$TripRoomCreateResponseFromJson(json);

  @override
  final int tripId;
  @override
  final String invitationCode;

  /// Create a copy of TripRoomCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomCreateResponseCopyWith<_TripRoomCreateResponse> get copyWith =>
      __$TripRoomCreateResponseCopyWithImpl<_TripRoomCreateResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TripRoomCreateResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomCreateResponse &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.invitationCode, invitationCode) ||
                other.invitationCode == invitationCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tripId, invitationCode);

  @override
  String toString() {
    return 'TripRoomCreateResponse(tripId: $tripId, invitationCode: $invitationCode)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomCreateResponseCopyWith<$Res>
    implements $TripRoomCreateResponseCopyWith<$Res> {
  factory _$TripRoomCreateResponseCopyWith(_TripRoomCreateResponse value,
          $Res Function(_TripRoomCreateResponse) _then) =
      __$TripRoomCreateResponseCopyWithImpl;
  @override
  @useResult
  $Res call({int tripId, String invitationCode});
}

/// @nodoc
class __$TripRoomCreateResponseCopyWithImpl<$Res>
    implements _$TripRoomCreateResponseCopyWith<$Res> {
  __$TripRoomCreateResponseCopyWithImpl(this._self, this._then);

  final _TripRoomCreateResponse _self;
  final $Res Function(_TripRoomCreateResponse) _then;

  /// Create a copy of TripRoomCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripId = null,
    Object? invitationCode = null,
  }) {
    return _then(_TripRoomCreateResponse(
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      invitationCode: null == invitationCode
          ? _self.invitationCode
          : invitationCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
