import 'package:equatable/equatable.dart';

class VisitedCountryEntity extends Equatable {
  final String country;
  final int visitCnt;
  final String? imageUrl;

  const VisitedCountryEntity({
    required this.country,
    required this.visitCnt,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        country,
        visitCnt,
        imageUrl,
      ];
}
