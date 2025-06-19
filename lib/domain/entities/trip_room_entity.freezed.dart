// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_room_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomEntity {
  int get id;
  String get name;
  String get type;
  DateTime get startDate;
  DateTime get endDate;
  String get country;
  String? get thumbnail;
  String get invitationCode;
  String get labelColor;
  bool get bookmark;
  String get domain;
  List<TripMemberEntity> get members;

  /// Create a copy of TripRoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomEntityCopyWith<TripRoomEntity> get copyWith =>
      _$TripRoomEntityCopyWithImpl<TripRoomEntity>(
          this as TripRoomEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomEntity &&
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
            const DeepCollectionEquality().equals(other.members, members));
  }

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
      const DeepCollectionEquality().hash(members));

  @override
  String toString() {
    return 'TripRoomEntity(id: $id, name: $name, type: $type, startDate: $startDate, endDate: $endDate, country: $country, thumbnail: $thumbnail, invitationCode: $invitationCode, labelColor: $labelColor, bookmark: $bookmark, domain: $domain, members: $members)';
  }
}

/// @nodoc
abstract mixin class $TripRoomEntityCopyWith<$Res> {
  factory $TripRoomEntityCopyWith(
          TripRoomEntity value, $Res Function(TripRoomEntity) _then) =
      _$TripRoomEntityCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      DateTime startDate,
      DateTime endDate,
      String country,
      String? thumbnail,
      String invitationCode,
      String labelColor,
      bool bookmark,
      String domain,
      List<TripMemberEntity> members});
}

/// @nodoc
class _$TripRoomEntityCopyWithImpl<$Res>
    implements $TripRoomEntityCopyWith<$Res> {
  _$TripRoomEntityCopyWithImpl(this._self, this._then);

  final TripRoomEntity _self;
  final $Res Function(TripRoomEntity) _then;

  /// Create a copy of TripRoomEntity
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
    Object? members = null,
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
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      members: null == members
          ? _self.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TripMemberEntity>,
    ));
  }
}

/// @nodoc

class _TripRoomEntity extends TripRoomEntity {
  const _TripRoomEntity(
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
      required final List<TripMemberEntity> members})
      : _members = members,
        super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
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
  final List<TripMemberEntity> _members;
  @override
  List<TripMemberEntity> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Create a copy of TripRoomEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomEntityCopyWith<_TripRoomEntity> get copyWith =>
      __$TripRoomEntityCopyWithImpl<_TripRoomEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomEntity &&
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
            const DeepCollectionEquality().equals(other._members, _members));
  }

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
      const DeepCollectionEquality().hash(_members));

  @override
  String toString() {
    return 'TripRoomEntity(id: $id, name: $name, type: $type, startDate: $startDate, endDate: $endDate, country: $country, thumbnail: $thumbnail, invitationCode: $invitationCode, labelColor: $labelColor, bookmark: $bookmark, domain: $domain, members: $members)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomEntityCopyWith<$Res>
    implements $TripRoomEntityCopyWith<$Res> {
  factory _$TripRoomEntityCopyWith(
          _TripRoomEntity value, $Res Function(_TripRoomEntity) _then) =
      __$TripRoomEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String type,
      DateTime startDate,
      DateTime endDate,
      String country,
      String? thumbnail,
      String invitationCode,
      String labelColor,
      bool bookmark,
      String domain,
      List<TripMemberEntity> members});
}

/// @nodoc
class __$TripRoomEntityCopyWithImpl<$Res>
    implements _$TripRoomEntityCopyWith<$Res> {
  __$TripRoomEntityCopyWithImpl(this._self, this._then);

  final _TripRoomEntity _self;
  final $Res Function(_TripRoomEntity) _then;

  /// Create a copy of TripRoomEntity
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
    Object? members = null,
  }) {
    return _then(_TripRoomEntity(
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
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      members: null == members
          ? _self._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TripMemberEntity>,
    ));
  }
}

/// @nodoc
mixin _$TripMemberEntity {
  String get uuid;
  String get nickname;
  String? get thumbnail;
  bool get leader;

  /// Create a copy of TripMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripMemberEntityCopyWith<TripMemberEntity> get copyWith =>
      _$TripMemberEntityCopyWithImpl<TripMemberEntity>(
          this as TripMemberEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripMemberEntity &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.leader, leader) || other.leader == leader));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, nickname, thumbnail, leader);

  @override
  String toString() {
    return 'TripMemberEntity(uuid: $uuid, nickname: $nickname, thumbnail: $thumbnail, leader: $leader)';
  }
}

/// @nodoc
abstract mixin class $TripMemberEntityCopyWith<$Res> {
  factory $TripMemberEntityCopyWith(
          TripMemberEntity value, $Res Function(TripMemberEntity) _then) =
      _$TripMemberEntityCopyWithImpl;
  @useResult
  $Res call({String uuid, String nickname, String? thumbnail, bool leader});
}

/// @nodoc
class _$TripMemberEntityCopyWithImpl<$Res>
    implements $TripMemberEntityCopyWith<$Res> {
  _$TripMemberEntityCopyWithImpl(this._self, this._then);

  final TripMemberEntity _self;
  final $Res Function(TripMemberEntity) _then;

  /// Create a copy of TripMemberEntity
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

class _TripMemberEntity implements TripMemberEntity {
  const _TripMemberEntity(
      {required this.uuid,
      required this.nickname,
      this.thumbnail,
      required this.leader});

  @override
  final String uuid;
  @override
  final String nickname;
  @override
  final String? thumbnail;
  @override
  final bool leader;

  /// Create a copy of TripMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripMemberEntityCopyWith<_TripMemberEntity> get copyWith =>
      __$TripMemberEntityCopyWithImpl<_TripMemberEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripMemberEntity &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.leader, leader) || other.leader == leader));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, nickname, thumbnail, leader);

  @override
  String toString() {
    return 'TripMemberEntity(uuid: $uuid, nickname: $nickname, thumbnail: $thumbnail, leader: $leader)';
  }
}

/// @nodoc
abstract mixin class _$TripMemberEntityCopyWith<$Res>
    implements $TripMemberEntityCopyWith<$Res> {
  factory _$TripMemberEntityCopyWith(
          _TripMemberEntity value, $Res Function(_TripMemberEntity) _then) =
      __$TripMemberEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String uuid, String nickname, String? thumbnail, bool leader});
}

/// @nodoc
class __$TripMemberEntityCopyWithImpl<$Res>
    implements _$TripMemberEntityCopyWith<$Res> {
  __$TripMemberEntityCopyWithImpl(this._self, this._then);

  final _TripMemberEntity _self;
  final $Res Function(_TripMemberEntity) _then;

  /// Create a copy of TripMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uuid = null,
    Object? nickname = null,
    Object? thumbnail = freezed,
    Object? leader = null,
  }) {
    return _then(_TripMemberEntity(
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
