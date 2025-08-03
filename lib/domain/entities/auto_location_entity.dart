import 'package:equatable/equatable.dart';

class AutoLocationEntity extends Equatable {
  final String placeId;
  final String address;
  final String? secondaryAddress;

  const AutoLocationEntity({
    required this.placeId,
    required this.address,
    this.secondaryAddress,
  });

  @override
  List<Object?> get props => [
        placeId,
        address,
        secondaryAddress,
      ];
}
