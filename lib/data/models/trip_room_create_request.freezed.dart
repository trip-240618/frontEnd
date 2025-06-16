// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_room_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomCreateRequest {
  String get name;
  String get type;
  String get startDate;
  String get endDate;
  String get country;
  String get thumbnail;
  String get labelColor;

  /// Create a copy of TripRoomCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomCreateRequestCopyWith<TripRoomCreateRequest> get copyWith =>
      _$TripRoomCreateRequestCopyWithImpl<TripRoomCreateRequest>(
          this as TripRoomCreateRequest, _$identity);

  /// Serializes this TripRoomCreateRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomCreateRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, startDate, endDate,
      country, thumbnail, labelColor);

  @override
  String toString() {
    return 'TripRoomCreateRequest(name: $name, type: $type, startDate: $startDate, endDate: $endDate, country: $country, thumbnail: $thumbnail, labelColor: $labelColor)';
  }
}

/// @nodoc
abstract mixin class $TripRoomCreateRequestCopyWith<$Res> {
  factory $TripRoomCreateRequestCopyWith(TripRoomCreateRequest value,
          $Res Function(TripRoomCreateRequest) _then) =
      _$TripRoomCreateRequestCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String type,
      String startDate,
      String endDate,
      String country,
      String thumbnail,
      String labelColor});
}

/// @nodoc
class _$TripRoomCreateRequestCopyWithImpl<$Res>
    implements $TripRoomCreateRequestCopyWith<$Res> {
  _$TripRoomCreateRequestCopyWithImpl(this._self, this._then);

  final TripRoomCreateRequest _self;
  final $Res Function(TripRoomCreateRequest) _then;

  /// Create a copy of TripRoomCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? country = null,
    Object? thumbnail = null,
    Object? labelColor = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TripRoomCreateRequest implements TripRoomCreateRequest {
  const _TripRoomCreateRequest(
      {required this.name,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.country,
      required this.thumbnail,
      required this.labelColor});
  factory _TripRoomCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$TripRoomCreateRequestFromJson(json);

  @override
  final String name;
  @override
  final String type;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String country;
  @override
  final String thumbnail;
  @override
  final String labelColor;

  /// Create a copy of TripRoomCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomCreateRequestCopyWith<_TripRoomCreateRequest> get copyWith =>
      __$TripRoomCreateRequestCopyWithImpl<_TripRoomCreateRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TripRoomCreateRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomCreateRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, startDate, endDate,
      country, thumbnail, labelColor);

  @override
  String toString() {
    return 'TripRoomCreateRequest(name: $name, type: $type, startDate: $startDate, endDate: $endDate, country: $country, thumbnail: $thumbnail, labelColor: $labelColor)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomCreateRequestCopyWith<$Res>
    implements $TripRoomCreateRequestCopyWith<$Res> {
  factory _$TripRoomCreateRequestCopyWith(_TripRoomCreateRequest value,
          $Res Function(_TripRoomCreateRequest) _then) =
      __$TripRoomCreateRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String type,
      String startDate,
      String endDate,
      String country,
      String thumbnail,
      String labelColor});
}

/// @nodoc
class __$TripRoomCreateRequestCopyWithImpl<$Res>
    implements _$TripRoomCreateRequestCopyWith<$Res> {
  __$TripRoomCreateRequestCopyWithImpl(this._self, this._then);

  final _TripRoomCreateRequest _self;
  final $Res Function(_TripRoomCreateRequest) _then;

  /// Create a copy of TripRoomCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? country = null,
    Object? thumbnail = null,
    Object? labelColor = null,
  }) {
    return _then(_TripRoomCreateRequest(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
