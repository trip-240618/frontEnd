import 'package:equatable/equatable.dart';

class TripRoomCreateEntity extends Equatable {
  final int tripId;
  final String invitationCode;

  const TripRoomCreateEntity({
    required this.tripId,
    required this.invitationCode,
  });

  @override
  List<Object> get props => [tripId, invitationCode];
}
