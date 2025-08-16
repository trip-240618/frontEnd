import 'package:equatable/equatable.dart';
import 'package:tripStory/data/models/request/scrap_modify_request.dart';

class ScrapUpdateEntity extends Equatable {
  final int id;
  final String title;
  final String content;
  final bool hasImage;
  final String color;
  final List<ScrapPhotoList> photoList;

  const ScrapUpdateEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.hasImage,
    required this.color,
    required this.photoList,
  });

  @override
  List<Object> get props => [id, title, content, hasImage, color, photoList];
}
