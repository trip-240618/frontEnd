// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Country {
  String get name;
  String get image;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CountryCopyWith<Country> get copyWith =>
      _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Country &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, image);

  @override
  String toString() {
    return 'Country(name: $name, image: $image)';
  }
}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) =
      _$CountryCopyWithImpl;
  @useResult
  $Res call({String name, String image});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res> implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Country implements Country {
  const _Country({required this.name, required this.image});

  @override
  final String name;
  @override
  final String image;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CountryCopyWith<_Country> get copyWith =>
      __$CountryCopyWithImpl<_Country>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Country &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, image);

  @override
  String toString() {
    return 'Country(name: $name, image: $image)';
  }
}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) =
      __$CountryCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String image});
}

/// @nodoc
class __$CountryCopyWithImpl<$Res> implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? image = null,
  }) {
    return _then(_Country(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CountryRegion {
  String get region;
  List<Country> get countries;

  /// Create a copy of CountryRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CountryRegionCopyWith<CountryRegion> get copyWith =>
      _$CountryRegionCopyWithImpl<CountryRegion>(
          this as CountryRegion, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CountryRegion &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality().equals(other.countries, countries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, region, const DeepCollectionEquality().hash(countries));

  @override
  String toString() {
    return 'CountryRegion(region: $region, countries: $countries)';
  }
}

/// @nodoc
abstract mixin class $CountryRegionCopyWith<$Res> {
  factory $CountryRegionCopyWith(
          CountryRegion value, $Res Function(CountryRegion) _then) =
      _$CountryRegionCopyWithImpl;
  @useResult
  $Res call({String region, List<Country> countries});
}

/// @nodoc
class _$CountryRegionCopyWithImpl<$Res>
    implements $CountryRegionCopyWith<$Res> {
  _$CountryRegionCopyWithImpl(this._self, this._then);

  final CountryRegion _self;
  final $Res Function(CountryRegion) _then;

  /// Create a copy of CountryRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = null,
    Object? countries = null,
  }) {
    return _then(_self.copyWith(
      region: null == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      countries: null == countries
          ? _self.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<Country>,
    ));
  }
}

/// @nodoc

class _CountryRegion implements CountryRegion {
  const _CountryRegion(
      {required this.region, required final List<Country> countries})
      : _countries = countries;

  @override
  final String region;
  final List<Country> _countries;
  @override
  List<Country> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  /// Create a copy of CountryRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CountryRegionCopyWith<_CountryRegion> get copyWith =>
      __$CountryRegionCopyWithImpl<_CountryRegion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CountryRegion &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, region, const DeepCollectionEquality().hash(_countries));

  @override
  String toString() {
    return 'CountryRegion(region: $region, countries: $countries)';
  }
}

/// @nodoc
abstract mixin class _$CountryRegionCopyWith<$Res>
    implements $CountryRegionCopyWith<$Res> {
  factory _$CountryRegionCopyWith(
          _CountryRegion value, $Res Function(_CountryRegion) _then) =
      __$CountryRegionCopyWithImpl;
  @override
  @useResult
  $Res call({String region, List<Country> countries});
}

/// @nodoc
class __$CountryRegionCopyWithImpl<$Res>
    implements _$CountryRegionCopyWith<$Res> {
  __$CountryRegionCopyWithImpl(this._self, this._then);

  final _CountryRegion _self;
  final $Res Function(_CountryRegion) _then;

  /// Create a copy of CountryRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? region = null,
    Object? countries = null,
  }) {
    return _then(_CountryRegion(
      region: null == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      countries: null == countries
          ? _self._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<Country>,
    ));
  }
}

// dart format on
