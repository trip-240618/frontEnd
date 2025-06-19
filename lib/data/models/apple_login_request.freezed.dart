// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apple_login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppleLoginRequest {
  String? get email;
  String? get familyName;
  String? get givenName;
  String get identityToken;
  String get state;
  String get userIdentifier;
  String? get fcmToken;

  /// Create a copy of AppleLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppleLoginRequestCopyWith<AppleLoginRequest> get copyWith =>
      _$AppleLoginRequestCopyWithImpl<AppleLoginRequest>(
          this as AppleLoginRequest, _$identity);

  /// Serializes this AppleLoginRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppleLoginRequest &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            (identical(other.givenName, givenName) ||
                other.givenName == givenName) &&
            (identical(other.identityToken, identityToken) ||
                other.identityToken == identityToken) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.userIdentifier, userIdentifier) ||
                other.userIdentifier == userIdentifier) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, familyName, givenName,
      identityToken, state, userIdentifier, fcmToken);

  @override
  String toString() {
    return 'AppleLoginRequest(email: $email, familyName: $familyName, givenName: $givenName, identityToken: $identityToken, state: $state, userIdentifier: $userIdentifier, fcmToken: $fcmToken)';
  }
}

/// @nodoc
abstract mixin class $AppleLoginRequestCopyWith<$Res> {
  factory $AppleLoginRequestCopyWith(
          AppleLoginRequest value, $Res Function(AppleLoginRequest) _then) =
      _$AppleLoginRequestCopyWithImpl;
  @useResult
  $Res call(
      {String? email,
      String? familyName,
      String? givenName,
      String identityToken,
      String state,
      String userIdentifier,
      String? fcmToken});
}

/// @nodoc
class _$AppleLoginRequestCopyWithImpl<$Res>
    implements $AppleLoginRequestCopyWith<$Res> {
  _$AppleLoginRequestCopyWithImpl(this._self, this._then);

  final AppleLoginRequest _self;
  final $Res Function(AppleLoginRequest) _then;

  /// Create a copy of AppleLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? familyName = freezed,
    Object? givenName = freezed,
    Object? identityToken = null,
    Object? state = null,
    Object? userIdentifier = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_self.copyWith(
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _self.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      givenName: freezed == givenName
          ? _self.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityToken: null == identityToken
          ? _self.identityToken
          : identityToken // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      userIdentifier: null == userIdentifier
          ? _self.userIdentifier
          : userIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AppleLoginRequest implements AppleLoginRequest {
  const _AppleLoginRequest(
      {this.email,
      this.familyName,
      this.givenName,
      required this.identityToken,
      required this.state,
      required this.userIdentifier,
      this.fcmToken});
  factory _AppleLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$AppleLoginRequestFromJson(json);

  @override
  final String? email;
  @override
  final String? familyName;
  @override
  final String? givenName;
  @override
  final String identityToken;
  @override
  final String state;
  @override
  final String userIdentifier;
  @override
  final String? fcmToken;

  /// Create a copy of AppleLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppleLoginRequestCopyWith<_AppleLoginRequest> get copyWith =>
      __$AppleLoginRequestCopyWithImpl<_AppleLoginRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppleLoginRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppleLoginRequest &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            (identical(other.givenName, givenName) ||
                other.givenName == givenName) &&
            (identical(other.identityToken, identityToken) ||
                other.identityToken == identityToken) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.userIdentifier, userIdentifier) ||
                other.userIdentifier == userIdentifier) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, familyName, givenName,
      identityToken, state, userIdentifier, fcmToken);

  @override
  String toString() {
    return 'AppleLoginRequest(email: $email, familyName: $familyName, givenName: $givenName, identityToken: $identityToken, state: $state, userIdentifier: $userIdentifier, fcmToken: $fcmToken)';
  }
}

/// @nodoc
abstract mixin class _$AppleLoginRequestCopyWith<$Res>
    implements $AppleLoginRequestCopyWith<$Res> {
  factory _$AppleLoginRequestCopyWith(
          _AppleLoginRequest value, $Res Function(_AppleLoginRequest) _then) =
      __$AppleLoginRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? email,
      String? familyName,
      String? givenName,
      String identityToken,
      String state,
      String userIdentifier,
      String? fcmToken});
}

/// @nodoc
class __$AppleLoginRequestCopyWithImpl<$Res>
    implements _$AppleLoginRequestCopyWith<$Res> {
  __$AppleLoginRequestCopyWithImpl(this._self, this._then);

  final _AppleLoginRequest _self;
  final $Res Function(_AppleLoginRequest) _then;

  /// Create a copy of AppleLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = freezed,
    Object? familyName = freezed,
    Object? givenName = freezed,
    Object? identityToken = null,
    Object? state = null,
    Object? userIdentifier = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_AppleLoginRequest(
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _self.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      givenName: freezed == givenName
          ? _self.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityToken: null == identityToken
          ? _self.identityToken
          : identityToken // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      userIdentifier: null == userIdentifier
          ? _self.userIdentifier
          : userIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
