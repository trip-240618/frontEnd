// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_room_calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRoomCalendarState {
  List<DateTime> get selectedDates;
  OneTimeEvent<bool>? get showDialog;

  /// Create a copy of TripRoomCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripRoomCalendarStateCopyWith<TripRoomCalendarState> get copyWith =>
      _$TripRoomCalendarStateCopyWithImpl<TripRoomCalendarState>(
          this as TripRoomCalendarState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TripRoomCalendarState &&
            const DeepCollectionEquality()
                .equals(other.selectedDates, selectedDates) &&
            (identical(other.showDialog, showDialog) ||
                other.showDialog == showDialog));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(selectedDates), showDialog);

  @override
  String toString() {
    return 'TripRoomCalendarState(selectedDates: $selectedDates, showDialog: $showDialog)';
  }
}

/// @nodoc
abstract mixin class $TripRoomCalendarStateCopyWith<$Res> {
  factory $TripRoomCalendarStateCopyWith(TripRoomCalendarState value,
          $Res Function(TripRoomCalendarState) _then) =
      _$TripRoomCalendarStateCopyWithImpl;
  @useResult
  $Res call({List<DateTime> selectedDates, OneTimeEvent<bool>? showDialog});
}

/// @nodoc
class _$TripRoomCalendarStateCopyWithImpl<$Res>
    implements $TripRoomCalendarStateCopyWith<$Res> {
  _$TripRoomCalendarStateCopyWithImpl(this._self, this._then);

  final TripRoomCalendarState _self;
  final $Res Function(TripRoomCalendarState) _then;

  /// Create a copy of TripRoomCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDates = null,
    Object? showDialog = freezed,
  }) {
    return _then(_self.copyWith(
      selectedDates: null == selectedDates
          ? _self.selectedDates
          : selectedDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      showDialog: freezed == showDialog
          ? _self.showDialog
          : showDialog // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<bool>?,
    ));
  }
}

/// @nodoc

class _TripRoomCalendarState implements TripRoomCalendarState {
  const _TripRoomCalendarState(
      {final List<DateTime> selectedDates = const [], this.showDialog})
      : _selectedDates = selectedDates;

  final List<DateTime> _selectedDates;
  @override
  @JsonKey()
  List<DateTime> get selectedDates {
    if (_selectedDates is EqualUnmodifiableListView) return _selectedDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedDates);
  }

  @override
  final OneTimeEvent<bool>? showDialog;

  /// Create a copy of TripRoomCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripRoomCalendarStateCopyWith<_TripRoomCalendarState> get copyWith =>
      __$TripRoomCalendarStateCopyWithImpl<_TripRoomCalendarState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TripRoomCalendarState &&
            const DeepCollectionEquality()
                .equals(other._selectedDates, _selectedDates) &&
            (identical(other.showDialog, showDialog) ||
                other.showDialog == showDialog));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_selectedDates), showDialog);

  @override
  String toString() {
    return 'TripRoomCalendarState(selectedDates: $selectedDates, showDialog: $showDialog)';
  }
}

/// @nodoc
abstract mixin class _$TripRoomCalendarStateCopyWith<$Res>
    implements $TripRoomCalendarStateCopyWith<$Res> {
  factory _$TripRoomCalendarStateCopyWith(_TripRoomCalendarState value,
          $Res Function(_TripRoomCalendarState) _then) =
      __$TripRoomCalendarStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<DateTime> selectedDates, OneTimeEvent<bool>? showDialog});
}

/// @nodoc
class __$TripRoomCalendarStateCopyWithImpl<$Res>
    implements _$TripRoomCalendarStateCopyWith<$Res> {
  __$TripRoomCalendarStateCopyWithImpl(this._self, this._then);

  final _TripRoomCalendarState _self;
  final $Res Function(_TripRoomCalendarState) _then;

  /// Create a copy of TripRoomCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedDates = null,
    Object? showDialog = freezed,
  }) {
    return _then(_TripRoomCalendarState(
      selectedDates: null == selectedDates
          ? _self._selectedDates
          : selectedDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      showDialog: freezed == showDialog
          ? _self.showDialog
          : showDialog // ignore: cast_nullable_to_non_nullable
              as OneTimeEvent<bool>?,
    ));
  }
}

// dart format on
