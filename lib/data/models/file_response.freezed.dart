// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileResponse {
  List<String> get preSignedUrls;

  /// Create a copy of FileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FileResponseCopyWith<FileResponse> get copyWith =>
      _$FileResponseCopyWithImpl<FileResponse>(
          this as FileResponse, _$identity);

  /// Serializes this FileResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FileResponse &&
            const DeepCollectionEquality()
                .equals(other.preSignedUrls, preSignedUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(preSignedUrls));

  @override
  String toString() {
    return 'FileResponse(preSignedUrls: $preSignedUrls)';
  }
}

/// @nodoc
abstract mixin class $FileResponseCopyWith<$Res> {
  factory $FileResponseCopyWith(
          FileResponse value, $Res Function(FileResponse) _then) =
      _$FileResponseCopyWithImpl;
  @useResult
  $Res call({List<String> preSignedUrls});
}

/// @nodoc
class _$FileResponseCopyWithImpl<$Res> implements $FileResponseCopyWith<$Res> {
  _$FileResponseCopyWithImpl(this._self, this._then);

  final FileResponse _self;
  final $Res Function(FileResponse) _then;

  /// Create a copy of FileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preSignedUrls = null,
  }) {
    return _then(_self.copyWith(
      preSignedUrls: null == preSignedUrls
          ? _self.preSignedUrls
          : preSignedUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FileResponse implements FileResponse {
  const _FileResponse({required final List<String> preSignedUrls})
      : _preSignedUrls = preSignedUrls;
  factory _FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);

  final List<String> _preSignedUrls;
  @override
  List<String> get preSignedUrls {
    if (_preSignedUrls is EqualUnmodifiableListView) return _preSignedUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preSignedUrls);
  }

  /// Create a copy of FileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FileResponseCopyWith<_FileResponse> get copyWith =>
      __$FileResponseCopyWithImpl<_FileResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FileResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FileResponse &&
            const DeepCollectionEquality()
                .equals(other._preSignedUrls, _preSignedUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_preSignedUrls));

  @override
  String toString() {
    return 'FileResponse(preSignedUrls: $preSignedUrls)';
  }
}

/// @nodoc
abstract mixin class _$FileResponseCopyWith<$Res>
    implements $FileResponseCopyWith<$Res> {
  factory _$FileResponseCopyWith(
          _FileResponse value, $Res Function(_FileResponse) _then) =
      __$FileResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<String> preSignedUrls});
}

/// @nodoc
class __$FileResponseCopyWithImpl<$Res>
    implements _$FileResponseCopyWith<$Res> {
  __$FileResponseCopyWithImpl(this._self, this._then);

  final _FileResponse _self;
  final $Res Function(_FileResponse) _then;

  /// Create a copy of FileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? preSignedUrls = null,
  }) {
    return _then(_FileResponse(
      preSignedUrls: null == preSignedUrls
          ? _self._preSignedUrls
          : preSignedUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
