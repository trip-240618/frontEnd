import 'package:equatable/equatable.dart';

class ScrapCreateEntity extends Equatable {
  final String title;
  final String content;
  final bool hasImage;
  final String color;
  final List<String> photoList;

  const ScrapCreateEntity({
    required this.title,
    required this.content,
    required this.hasImage,
    required this.color,
    required this.photoList,
  });

  @override
  List<Object> get props => [title, content, hasImage, color, photoList];
}
