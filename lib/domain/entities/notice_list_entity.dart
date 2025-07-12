import 'package:equatable/equatable.dart';

class NoticeListEntity extends Equatable {
  final int id;
  final String type;
  final String title;
  final DateTime createDate;

  const NoticeListEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.createDate,
  });

  @override
  List<Object> get props => [
        id,
        type,
        title,
        createDate,
      ];
}
