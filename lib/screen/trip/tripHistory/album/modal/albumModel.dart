part 'albumModel.g.dart';

class AlbumModel {
  final String id;
  final String name;
  final List images;

  AlbumModel({
    required this.id,
    required this.name,
    required this.images,
  });

  /// Connect the generated `fromJson` method to the `AlbumModel` class.
  factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);

  /// Connect the generated `toJson` method to the `AlbumModel` class.
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

}