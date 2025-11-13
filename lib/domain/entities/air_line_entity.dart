import 'package:equatable/equatable.dart';

class AirLineEntity extends Equatable {
  final String name;
  final String code;

  const AirLineEntity({
    required this.name,
    required this.code,
  });

  @override
  List<Object> get props => [name, code];
}
