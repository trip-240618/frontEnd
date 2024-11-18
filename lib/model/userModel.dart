import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  final String uuid;
  final String? name;
  final String? nickName;
  final String? memo;
  final String? thumbnail;
  final String? profileImg;
  final String? type;
  final String? createDate;

  UserModel({
    required this.uuid,
     this.name,
     this.nickName,
     this.memo,
     this.thumbnail,
     this.profileImg,
     this.type,
     this.createDate,
  });

  /// Connect the generated `fromJson` method to the `UserModel` class.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Connect the generated `toJson` method to the `UserModel` class.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
