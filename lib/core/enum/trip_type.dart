import 'package:freezed_annotation/freezed_annotation.dart';

enum TripType {
  @JsonValue("j")
  j("j"),
  @JsonValue("p")
  p("p");

  final String type;

  const TripType(this.type);

  factory TripType.fromType(String stringType) => TripType.values.firstWhere(
        (type) => type.type == stringType,
      );
}
