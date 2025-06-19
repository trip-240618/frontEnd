// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRequest {
  String get displayName;
  String get email;
  String get id;
  String get photoUrl;
  String? get serverAuthCode;
  String? get fcmToken;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserRequestCopyWith<UserRequest> get copyWith =>
      _$UserRequestCopyWithImpl<UserRequest>(this as UserRequest, _$identity);

  /// Serializes this UserRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserRequest &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.serverAuthCode, serverAuthCode) ||
                other.serverAuthCode == serverAuthCode) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, displayName, email, id, photoUrl, serverAuthCode, fcmToken);

  @override
  String toString() {
    return 'UserRequest(displayName: $displayName, email: $email, id: $id, photoUrl: $photoUrl, serverAuthCode: $serverAuthCode, fcmToken: $fcmToken)';
  }
}

/// @nodoc
abstract mixin class $UserRequestCopyWith<$Res> {
  factory $UserRequestCopyWith(
          UserRequest value, $Res Function(UserRequest) _then) =
      _$UserRequestCopyWithImpl;
  @useResult
  $Res call(
      {String displayName,
      String email,
      String id,
      String photoUrl,
      String? serverAuthCode,
      String? fcmToken});
}

/// @nodoc
class _$UserRequestCopyWithImpl<$Res> implements $UserRequestCopyWith<$Res> {
  _$UserRequestCopyWithImpl(this._self, this._then);

  final UserRequest _self;
  final $Res Function(UserRequest) _then;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? email = null,
    Object? id = null,
    Object? photoUrl = null,
    Object? serverAuthCode = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_self.copyWith(
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      serverAuthCode: freezed == serverAuthCode
          ? _self.serverAuthCode
          : serverAuthCode // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserRequest implements UserRequest {
  const _UserRequest(
      {required this.displayName,
      required this.email,
      required this.id,
      required this.photoUrl,
      this.serverAuthCode,
      this.fcmToken});
  factory _UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  @override
  final String displayName;
  @override
  final String email;
  @override
  final String id;
  @override
  final String photoUrl;
  @override
  final String? serverAuthCode;
  @override
  final String? fcmToken;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserRequestCopyWith<_UserRequest> get copyWith =>
      __$UserRequestCopyWithImpl<_UserRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserRequest &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.serverAuthCode, serverAuthCode) ||
                other.serverAuthCode == serverAuthCode) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, displayName, email, id, photoUrl, serverAuthCode, fcmToken);

  @override
  String toString() {
    return 'UserRequest(displayName: $displayName, email: $email, id: $id, photoUrl: $photoUrl, serverAuthCode: $serverAuthCode, fcmToken: $fcmToken)';
  }
}

/// @nodoc
abstract mixin class _$UserRequestCopyWith<$Res>
    implements $UserRequestCopyWith<$Res> {
  factory _$UserRequestCopyWith(
          _UserRequest value, $Res Function(_UserRequest) _then) =
      __$UserRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String displayName,
      String email,
      String id,
      String photoUrl,
      String? serverAuthCode,
      String? fcmToken});
}

/// @nodoc
class __$UserRequestCopyWithImpl<$Res> implements _$UserRequestCopyWith<$Res> {
  __$UserRequestCopyWithImpl(this._self, this._then);

  final _UserRequest _self;
  final $Res Function(_UserRequest) _then;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? displayName = null,
    Object? email = null,
    Object? id = null,
    Object? photoUrl = null,
    Object? serverAuthCode = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_UserRequest(
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      serverAuthCode: freezed == serverAuthCode
          ? _self.serverAuthCode
          : serverAuthCode // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
