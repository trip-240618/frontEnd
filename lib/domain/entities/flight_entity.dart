import 'package:equatable/equatable.dart';

class FlightEntity extends Equatable {
  int? id;
  final String airlineCode;
  final int airlineNumber;
  final DateTime departureDateTime;
  final String departureAirport;
  String? departureAirportKr;
  final DateTime arrivalDateTime;
  final String arrivalAirport;
  String? arrivalAirportKr;

  FlightEntity({
    this.id,
    required this.airlineCode,
    required this.airlineNumber,
    required this.departureDateTime,
    required this.departureAirport,
    this.departureAirportKr,
    required this.arrivalDateTime,
    required this.arrivalAirport,
    this.arrivalAirportKr,
  });

  @override
  List<Object?> get props => [
        id,
        airlineCode,
        airlineNumber,
        departureDateTime,
        departureAirport,
        departureAirportKr,
        arrivalDateTime,
        arrivalAirport,
        arrivalAirportKr,
      ];
}
