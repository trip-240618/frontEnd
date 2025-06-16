// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_room_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomResponse {
  int get id;
  String get name;
  String get type;
  String get startDate;
  String get endDate;
  String get country;
  String? get thumbnail;
  String get invitationCode;
  String get labelColor;
  bool get bookmark;
  String get domain;
  List<TripMember> get tripMemberDtoList;

  /// Create a copy of TripRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomResponseCopyWith<TripRoomResponse> get copyWith =>
      _$TripRoomResponseCopyWithImpl<TripRoomResponse>(
          this as TripRoomResponse, _$identity);

  /// Serializes this TripRoomResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.invitationCode, invitationCode) ||
                other.invitationCode == invitationCode) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.bookmark, bookmark) ||
                other.bookmark == bookmark) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            const DeepCollectionEquality()
                .equals(other.tripMemberDtoList, tripMemberDtoList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      startDate,
      endDate,
      country,
      thumbnail,
      invitationCode,
      labelColor,
      bookmark,
      domain,
      const DeepCollectionEquality().hash(tripMemberDtoList));

  @override
  String toString() {
    return 'TripRoomResponse(id: $id, name: $name, type: $type, startDate: $startDate, endDate: $endDate, country: $country, thumbnail: $thumbnail, invitationCode: $invitationCode, labelColor: $labelColor, bookmark: $bookmark, domain: $domain, tripMemberDtoList: $tripMemberDtoList)';
  }
}

/// @nodoc
abstract mixin class $TripRoomResponseCopyWith<$Res> {
  factory $TripRoomResponseCopyWith(
          TripRoomResponse value, $Res Function(TripRoomResponse) _then) =
      _$TripRoomResponseCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String startDate,
      String endDate,
      String country,
      String? thumbnail,
      String invitationCode,
      String labelColor,
      bool bookmark,
      String domain,
      List<TripMember> tripMemberDtoList});
}

/// @nodoc
class _$TripRoomResponseCopyWithImpl<$Res>
    implements $TripRoomResponseCopyWith<$Res> {
  _$TripRoomResponseCopyWithImpl(this._self, this._then);

  final TripRoomResponse _self;
  final $Res Function(TripRoomResponse) _then;

  /// Create a copy of TripRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? country = null,
    Object? thumbnail = freezed,
    Object? invitationCode = null,
    Object? labelColor = null,
    Object? bookmark = null,
    Object? domain = null,
    Object? tripMemberDtoList = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      invitationCode: null == invitationCode
          ? _self.invitationCode
          : invitationCode // ignore: cast_nullable_to_non_nullable
              as String,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
      bookmark: null == bookmark
          ? _self.bookmark
          : bookmark // ignore: cast_nullable_to_non_nullable
              as bool,
      domain: null == domain
          ? _self.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      tripMemberDtoList: null == tripMemberDtoList
          ? _self.tripMemberDtoList
          : tripMemberDtoList // ignore: cast_nullable_to_non_nullable
              as List<TripMember>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TripRoomResponse extends TripRoomResponse {
  const _TripRoomResponse(
      {required this.id,
      required this.name,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.country,
      this.thumbnail,
      required this.invitationCode,
      required this.labelColor,
      required this.bookmark,
      required this.domain,
      required final List<TripMember> tripMemberDtoList})
      : _tripMemberDtoList = tripMemberDtoList,
        super._();
  factory _TripRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$TripRoomResponseFromJson(json);

  @override
  final int id;
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
  final String? thumbnail;
  @override
  final String invitationCode;
  @override
  final String labelColor;
  @override
  final bool bookmark;
  @override
  final String domain;
  final List<TripMember> _tripMemberDtoList;
  @override
  List<TripMember> get tripMemberDtoList {
    if (_tripMemberDtoList is EqualUnmodifiableListView)
      return _tripMemberDtoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tripMemberDtoList);
  }

  /// Create a copy of TripRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomResponseCopyWith<_TripRoomResponse> get copyWith =>
      __$TripRoomResponseCopyWithImpl<_TripRoomResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TripRoomResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.invitationCode, invitationCode) ||
                other.invitationCode == invitationCode) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.bookmark, bookmark) ||
                other.bookmark == bookmark) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            const DeepCollectionEquality()
                .equals(other._tripMemberDtoList, _tripMemberDtoList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      startDate,
      endDate,
      country,
      thumbnail,
      invitationCode,
      labelColor,
      bookmark,
      domain,
      const DeepCollectionEquality().hash(_tripMemberDtoList));

  @override
  String toString() {
    return 'TripRoomResponse(id: $id, name: $name, type: $type, startDate: $startDate, endDate: $endDate, country: $country, thumbnail: $thumbnail, invitationCode: $invitationCode, labelColor: $labelColor, bookmark: $bookmark, domain: $domain, tripMemberDtoList: $tripMemberDtoList)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomResponseCopyWith<$Res>
    implements $TripRoomResponseCopyWith<$Res> {
  factory _$TripRoomResponseCopyWith(
          _TripRoomResponse value, $Res Function(_TripRoomResponse) _then) =
      __$TripRoomResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      String startDate,
      String endDate,
      String country,
      String? thumbnail,
      String invitationCode,
      String labelColor,
      bool bookmark,
      String domain,
      List<TripMember> tripMemberDtoList});
}

/// @nodoc
class __$TripRoomResponseCopyWithImpl<$Res>
    implements _$TripRoomResponseCopyWith<$Res> {
  __$TripRoomResponseCopyWithImpl(this._self, this._then);

  final _TripRoomResponse _self;
  final $Res Function(_TripRoomResponse) _then;

  /// Create a copy of TripRoomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? country = null,
    Object? thumbnail = freezed,
    Object? invitationCode = null,
    Object? labelColor = null,
    Object? bookmark = null,
    Object? domain = null,
    Object? tripMemberDtoList = null,
  }) {
    return _then(_TripRoomResponse(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      invitationCode: null == invitationCode
          ? _self.invitationCode
          : invitationCode // ignore: cast_nullable_to_non_nullable
              as String,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
      bookmark: null == bookmark
          ? _self.bookmark
          : bookmark // ignore: cast_nullable_to_non_nullable
              as bool,
      domain: null == domain
          ? _self.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      tripMemberDtoList: null == tripMemberDtoList
          ? _self._tripMemberDtoList
          : tripMemberDtoList // ignore: cast_nullable_to_non_nullable
              as List<TripMember>,
    ));
  }
}

/// @nodoc
mixin _$TripMember {
  String get uuid;
  String get nickname;
  String? get thumbnail;
  bool get leader;

  /// Create a copy of TripMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripMemberCopyWith<TripMember> get copyWith =>
      _$TripMemberCopyWithImpl<TripMember>(this as TripMember, _$identity);

  /// Serializes this TripMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripMember &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.leader, leader) || other.leader == leader));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, nickname, thumbnail, leader);

  @override
  String toString() {
    return 'TripMember(uuid: $uuid, nickname: $nickname, thumbnail: $thumbnail, leader: $leader)';
  }
}

/// @nodoc
abstract mixin class $TripMemberCopyWith<$Res> {
  factory $TripMemberCopyWith(
          TripMember value, $Res Function(TripMember) _then) =
      _$TripMemberCopyWithImpl;
  @useResult
  $Res call({String uuid, String nickname, String? thumbnail, bool leader});
}

/// @nodoc
class _$TripMemberCopyWithImpl<$Res> implements $TripMemberCopyWith<$Res> {
  _$TripMemberCopyWithImpl(this._self, this._then);

  final TripMember _self;
  final $Res Function(TripMember) _then;

  /// Create a copy of TripMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? nickname = null,
    Object? thumbnail = freezed,
    Object? leader = null,
  }) {
    return _then(_self.copyWith(
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      leader: null == leader
          ? _self.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TripMember implements TripMember {
  const _TripMember(
      {required this.uuid,
      required this.nickname,
      this.thumbnail,
      required this.leader});
  factory _TripMember.fromJson(Map<String, dynamic> json) =>
      _$TripMemberFromJson(json);

  @override
  final String uuid;
  @override
  final String nickname;
  @override
  final String? thumbnail;
  @override
  final bool leader;

  /// Create a copy of TripMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripMemberCopyWith<_TripMember> get copyWith =>
      __$TripMemberCopyWithImpl<_TripMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TripMemberToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripMember &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.leader, leader) || other.leader == leader));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, nickname, thumbnail, leader);

  @override
  String toString() {
    return 'TripMember(uuid: $uuid, nickname: $nickname, thumbnail: $thumbnail, leader: $leader)';
  }
}

/// @nodoc
abstract mixin class _$TripMemberCopyWith<$Res>
    implements $TripMemberCopyWith<$Res> {
  factory _$TripMemberCopyWith(
          _TripMember value, $Res Function(_TripMember) _then) =
      __$TripMemberCopyWithImpl;
  @override
  @useResult
  $Res call({String uuid, String nickname, String? thumbnail, bool leader});
}

/// @nodoc
class __$TripMemberCopyWithImpl<$Res> implements _$TripMemberCopyWith<$Res> {
  __$TripMemberCopyWithImpl(this._self, this._then);

  final _TripMember _self;
  final $Res Function(_TripMember) _then;

  /// Create a copy of TripMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uuid = null,
    Object? nickname = null,
    Object? thumbnail = freezed,
    Object? leader = null,
  }) {
    return _then(_TripMember(
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      leader: null == leader
          ? _self.leader
          : leader // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
