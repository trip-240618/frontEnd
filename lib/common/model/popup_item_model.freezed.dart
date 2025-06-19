// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popup_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PopupItemModel {
  String get nickname;
  String? get profileImg;

  /// Create a copy of PopupItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PopupItemModelCopyWith<PopupItemModel> get copyWith =>
      _$PopupItemModelCopyWithImpl<PopupItemModel>(
          this as PopupItemModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PopupItemModel &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileImg, profileImg) ||
                other.profileImg == profileImg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nickname, profileImg);

  @override
  String toString() {
    return 'PopupItemModel(nickname: $nickname, profileImg: $profileImg)';
  }
}

/// @nodoc
abstract mixin class $PopupItemModelCopyWith<$Res> {
  factory $PopupItemModelCopyWith(
          PopupItemModel value, $Res Function(PopupItemModel) _then) =
      _$PopupItemModelCopyWithImpl;
  @useResult
  $Res call({String nickname, String? profileImg});
}

/// @nodoc
class _$PopupItemModelCopyWithImpl<$Res>
    implements $PopupItemModelCopyWith<$Res> {
  _$PopupItemModelCopyWithImpl(this._self, this._then);

  final PopupItemModel _self;
  final $Res Function(PopupItemModel) _then;

  /// Create a copy of PopupItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? profileImg = freezed,
  }) {
    return _then(_self.copyWith(
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profileImg: freezed == profileImg
          ? _self.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _PopupItemModel implements PopupItemModel {
  const _PopupItemModel({required this.nickname, this.profileImg});

  @override
  final String nickname;
  @override
  final String? profileImg;

  /// Create a copy of PopupItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PopupItemModelCopyWith<_PopupItemModel> get copyWith =>
      __$PopupItemModelCopyWithImpl<_PopupItemModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PopupItemModel &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileImg, profileImg) ||
                other.profileImg == profileImg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nickname, profileImg);

  @override
  String toString() {
    return 'PopupItemModel(nickname: $nickname, profileImg: $profileImg)';
  }
}

/// @nodoc
abstract mixin class _$PopupItemModelCopyWith<$Res>
    implements $PopupItemModelCopyWith<$Res> {
  factory _$PopupItemModelCopyWith(
          _PopupItemModel value, $Res Function(_PopupItemModel) _then) =
      __$PopupItemModelCopyWithImpl;
  @override
  @useResult
  $Res call({String nickname, String? profileImg});
}

/// @nodoc
class __$PopupItemModelCopyWithImpl<$Res>
    implements _$PopupItemModelCopyWith<$Res> {
  __$PopupItemModelCopyWithImpl(this._self, this._then);

  final _PopupItemModel _self;
  final $Res Function(_PopupItemModel) _then;

  /// Create a copy of PopupItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nickname = null,
    Object? profileImg = freezed,
  }) {
    return _then(_PopupItemModel(
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profileImg: freezed == profileImg
          ? _self.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
