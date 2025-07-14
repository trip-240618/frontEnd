import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_modify_request.freezed.dart';
part 'user_modify_request.g.dart';

@freezed
abstract class UserModifyRequest with _$UserModifyRequest {
  const factory UserModifyRequest({
    required String nickname,
    String? memo,
    String? thumbnail,
    String? profileImg,
  }) = _UserModifyRequest;

  factory UserModifyRequest.fromJson(Map<String, dynamic> json) => _$UserModifyRequestFromJson(json);
}
