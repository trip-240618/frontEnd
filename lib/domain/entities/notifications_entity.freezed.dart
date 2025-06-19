// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationsEntity {
  int get id;
  String get labelColor;
  String get destination;
  String get title;
  String get content;
  DateTime get createDate;
  bool get read;

  /// Create a copy of NotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationsEntityCopyWith<NotificationsEntity> get copyWith =>
      _$NotificationsEntityCopyWithImpl<NotificationsEntity>(
          this as NotificationsEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationsEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.read, read) || other.read == read));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, labelColor, destination,
      title, content, createDate, read);

  @override
  String toString() {
    return 'NotificationsEntity(id: $id, labelColor: $labelColor, destination: $destination, title: $title, content: $content, createDate: $createDate, read: $read)';
  }
}

/// @nodoc
abstract mixin class $NotificationsEntityCopyWith<$Res> {
  factory $NotificationsEntityCopyWith(
          NotificationsEntity value, $Res Function(NotificationsEntity) _then) =
      _$NotificationsEntityCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String labelColor,
      String destination,
      String title,
      String content,
      DateTime createDate,
      bool read});
}

/// @nodoc
class _$NotificationsEntityCopyWithImpl<$Res>
    implements $NotificationsEntityCopyWith<$Res> {
  _$NotificationsEntityCopyWithImpl(this._self, this._then);

  final NotificationsEntity _self;
  final $Res Function(NotificationsEntity) _then;

  /// Create a copy of NotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelColor = null,
    Object? destination = null,
    Object? title = null,
    Object? content = null,
    Object? createDate = null,
    Object? read = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _NotificationsEntity implements NotificationsEntity {
  const _NotificationsEntity(
      {required this.id,
      required this.labelColor,
      required this.destination,
      required this.title,
      required this.content,
      required this.createDate,
      required this.read});

  @override
  final int id;
  @override
  final String labelColor;
  @override
  final String destination;
  @override
  final String title;
  @override
  final String content;
  @override
  final DateTime createDate;
  @override
  final bool read;

  /// Create a copy of NotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationsEntityCopyWith<_NotificationsEntity> get copyWith =>
      __$NotificationsEntityCopyWithImpl<_NotificationsEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationsEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.read, read) || other.read == read));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, labelColor, destination,
      title, content, createDate, read);

  @override
  String toString() {
    return 'NotificationsEntity(id: $id, labelColor: $labelColor, destination: $destination, title: $title, content: $content, createDate: $createDate, read: $read)';
  }
}

/// @nodoc
abstract mixin class _$NotificationsEntityCopyWith<$Res>
    implements $NotificationsEntityCopyWith<$Res> {
  factory _$NotificationsEntityCopyWith(_NotificationsEntity value,
          $Res Function(_NotificationsEntity) _then) =
      __$NotificationsEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String labelColor,
      String destination,
      String title,
      String content,
      DateTime createDate,
      bool read});
}

/// @nodoc
class __$NotificationsEntityCopyWithImpl<$Res>
    implements _$NotificationsEntityCopyWith<$Res> {
  __$NotificationsEntityCopyWithImpl(this._self, this._then);

  final _NotificationsEntity _self;
  final $Res Function(_NotificationsEntity) _then;

  /// Create a copy of NotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? labelColor = null,
    Object? destination = null,
    Object? title = null,
    Object? content = null,
    Object? createDate = null,
    Object? read = null,
  }) {
    return _then(_NotificationsEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      labelColor: null == labelColor
          ? _self.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _self.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
