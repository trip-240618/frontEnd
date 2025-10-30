import 'package:equatable/equatable.dart';

class VersionEntity extends Equatable {
  final int id;
  final String androidVersion;
  final String iosVersion;
  final bool forceUpdate;
  final String createDate;

  const VersionEntity({
    required this.id,
    required this.androidVersion,
    required this.iosVersion,
    required this.forceUpdate,
    required this.createDate,
  });

  @override
  List<Object> get props => [
        id,
        androidVersion,
        iosVersion,
        forceUpdate,
        createDate,
      ];
}
