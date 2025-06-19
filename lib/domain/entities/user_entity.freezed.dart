// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEntity {
  String get uuid;
  String get name;
  String get nickName;
  String get memo;
  String get thumbnail;
  String get profileImg;
  UserType get type;
  DateTime get createDate;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<UserEntity> get copyWith =>
      _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserEntity &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.profileImg, profileImg) ||
                other.profileImg == profileImg) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, name, nickName, memo,
      thumbnail, profileImg, type, createDate);

  @override
  String toString() {
    return 'UserEntity(uuid: $uuid, name: $name, nickName: $nickName, memo: $memo, thumbnail: $thumbnail, profileImg: $profileImg, type: $type, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) _then) =
      _$UserEntityCopyWithImpl;
  @useResult
  $Res call(
      {String uuid,
      String name,
      String nickName,
      String memo,
      String thumbnail,
      String profileImg,
      UserType type,
      DateTime createDate});
}

/// @nodoc
class _$UserEntityCopyWithImpl<$Res> implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? nickName = null,
    Object? memo = null,
    Object? thumbnail = null,
    Object? profileImg = null,
    Object? type = null,
    Object? createDate = null,
  }) {
    return _then(_self.copyWith(
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: null == nickName
          ? _self.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _self.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      profileImg: null == profileImg
          ? _self.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _UserEntity extends UserEntity {
  const _UserEntity(
      {required this.uuid,
      required this.name,
      required this.nickName,
      required this.memo,
      required this.thumbnail,
      required this.profileImg,
      required this.type,
      required this.createDate})
      : super._();

  @override
  final String uuid;
  @override
  final String name;
  @override
  final String nickName;
  @override
  final String memo;
  @override
  final String thumbnail;
  @override
  final String profileImg;
  @override
  final UserType type;
  @override
  final DateTime createDate;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserEntityCopyWith<_UserEntity> get copyWith =>
      __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserEntity &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.profileImg, profileImg) ||
                other.profileImg == profileImg) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, name, nickName, memo,
      thumbnail, profileImg, type, createDate);

  @override
  String toString() {
    return 'UserEntity(uuid: $uuid, name: $name, nickName: $nickName, memo: $memo, thumbnail: $thumbnail, profileImg: $profileImg, type: $type, createDate: $createDate)';
  }
}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res>
    implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(
          _UserEntity value, $Res Function(_UserEntity) _then) =
      __$UserEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uuid,
      String name,
      String nickName,
      String memo,
      String thumbnail,
      String profileImg,
      UserType type,
      DateTime createDate});
}

/// @nodoc
class __$UserEntityCopyWithImpl<$Res> implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? nickName = null,
    Object? memo = null,
    Object? thumbnail = null,
    Object? profileImg = null,
    Object? type = null,
    Object? createDate = null,
  }) {
    return _then(_UserEntity(
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: null == nickName
          ? _self.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _self.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      profileImg: null == profileImg
          ? _self.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
