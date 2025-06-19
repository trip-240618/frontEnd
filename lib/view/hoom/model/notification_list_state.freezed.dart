// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationListState {
  List<NotificationsEntity> get notificationItems;
  NotificationType get notificationType;

  /// Create a copy of NotificationListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationListStateCopyWith<NotificationListState> get copyWith =>
      _$NotificationListStateCopyWithImpl<NotificationListState>(
          this as NotificationListState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationListState &&
            const DeepCollectionEquality()
                .equals(other.notificationItems, notificationItems) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(notificationItems), notificationType);

  @override
  String toString() {
    return 'NotificationListState(notificationItems: $notificationItems, notificationType: $notificationType)';
  }
}

/// @nodoc
abstract mixin class $NotificationListStateCopyWith<$Res> {
  factory $NotificationListStateCopyWith(NotificationListState value,
          $Res Function(NotificationListState) _then) =
      _$NotificationListStateCopyWithImpl;
  @useResult
  $Res call(
      {List<NotificationsEntity> notificationItems,
      NotificationType notificationType});
}

/// @nodoc
class _$NotificationListStateCopyWithImpl<$Res>
    implements $NotificationListStateCopyWith<$Res> {
  _$NotificationListStateCopyWithImpl(this._self, this._then);

  final NotificationListState _self;
  final $Res Function(NotificationListState) _then;

  /// Create a copy of NotificationListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationItems = null,
    Object? notificationType = null,
  }) {
    return _then(_self.copyWith(
      notificationItems: null == notificationItems
          ? _self.notificationItems
          : notificationItems // ignore: cast_nullable_to_non_nullable
              as List<NotificationsEntity>,
      notificationType: null == notificationType
          ? _self.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as NotificationType,
    ));
  }
}

/// @nodoc

class _NotificationListState extends NotificationListState {
  const _NotificationListState(
      {final List<NotificationsEntity> notificationItems = const [],
      this.notificationType = NotificationType.all})
      : _notificationItems = notificationItems,
        super._();

  final List<NotificationsEntity> _notificationItems;
  @override
  @JsonKey()
  List<NotificationsEntity> get notificationItems {
    if (_notificationItems is EqualUnmodifiableListView)
      return _notificationItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationItems);
  }

  @override
  @JsonKey()
  final NotificationType notificationType;

  /// Create a copy of NotificationListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationListStateCopyWith<_NotificationListState> get copyWith =>
      __$NotificationListStateCopyWithImpl<_NotificationListState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationListState &&
            const DeepCollectionEquality()
                .equals(other._notificationItems, _notificationItems) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_notificationItems),
      notificationType);

  @override
  String toString() {
    return 'NotificationListState(notificationItems: $notificationItems, notificationType: $notificationType)';
  }
}

/// @nodoc
abstract mixin class _$NotificationListStateCopyWith<$Res>
    implements $NotificationListStateCopyWith<$Res> {
  factory _$NotificationListStateCopyWith(_NotificationListState value,
          $Res Function(_NotificationListState) _then) =
      __$NotificationListStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<NotificationsEntity> notificationItems,
      NotificationType notificationType});
}

/// @nodoc
class __$NotificationListStateCopyWithImpl<$Res>
    implements _$NotificationListStateCopyWith<$Res> {
  __$NotificationListStateCopyWithImpl(this._self, this._then);

  final _NotificationListState _self;
  final $Res Function(_NotificationListState) _then;

  /// Create a copy of NotificationListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notificationItems = null,
    Object? notificationType = null,
  }) {
    return _then(_NotificationListState(
      notificationItems: null == notificationItems
          ? _self._notificationItems
          : notificationItems // ignore: cast_nullable_to_non_nullable
              as List<NotificationsEntity>,
      notificationType: null == notificationType
          ? _self.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as NotificationType,
    ));
  }
}

// dart format on
