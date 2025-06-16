// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileRequest {
  String get prefix;
  int get photoCnt;

  /// Create a copy of FileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FileRequestCopyWith<FileRequest> get copyWith =>
      _$FileRequestCopyWithImpl<FileRequest>(this as FileRequest, _$identity);

  /// Serializes this FileRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FileRequest &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.photoCnt, photoCnt) ||
                other.photoCnt == photoCnt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, prefix, photoCnt);

  @override
  String toString() {
    return 'FileRequest(prefix: $prefix, photoCnt: $photoCnt)';
  }
}

/// @nodoc
abstract mixin class $FileRequestCopyWith<$Res> {
  factory $FileRequestCopyWith(
          FileRequest value, $Res Function(FileRequest) _then) =
      _$FileRequestCopyWithImpl;
  @useResult
  $Res call({String prefix, int photoCnt});
}

/// @nodoc
class _$FileRequestCopyWithImpl<$Res> implements $FileRequestCopyWith<$Res> {
  _$FileRequestCopyWithImpl(this._self, this._then);

  final FileRequest _self;
  final $Res Function(FileRequest) _then;

  /// Create a copy of FileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefix = null,
    Object? photoCnt = null,
  }) {
    return _then(_self.copyWith(
      prefix: null == prefix
          ? _self.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      photoCnt: null == photoCnt
          ? _self.photoCnt
          : photoCnt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FileRequest implements FileRequest {
  const _FileRequest({required this.prefix, required this.photoCnt});
  factory _FileRequest.fromJson(Map<String, dynamic> json) =>
      _$FileRequestFromJson(json);

  @override
  final String prefix;
  @override
  final int photoCnt;

  /// Create a copy of FileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FileRequestCopyWith<_FileRequest> get copyWith =>
      __$FileRequestCopyWithImpl<_FileRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FileRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FileRequest &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.photoCnt, photoCnt) ||
                other.photoCnt == photoCnt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, prefix, photoCnt);

  @override
  String toString() {
    return 'FileRequest(prefix: $prefix, photoCnt: $photoCnt)';
  }
}

/// @nodoc
abstract mixin class _$FileRequestCopyWith<$Res>
    implements $FileRequestCopyWith<$Res> {
  factory _$FileRequestCopyWith(
          _FileRequest value, $Res Function(_FileRequest) _then) =
      __$FileRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String prefix, int photoCnt});
}

/// @nodoc
class __$FileRequestCopyWithImpl<$Res> implements _$FileRequestCopyWith<$Res> {
  __$FileRequestCopyWithImpl(this._self, this._then);

  final _FileRequest _self;
  final $Res Function(_FileRequest) _then;

  /// Create a copy of FileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? prefix = null,
    Object? photoCnt = null,
  }) {
    return _then(_FileRequest(
      prefix: null == prefix
          ? _self.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      photoCnt: null == photoCnt
          ? _self.photoCnt
          : photoCnt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
