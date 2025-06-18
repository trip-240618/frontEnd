import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';
part 'user_request.g.dart';

@freezed
abstract class UserRequest with _$UserRequest {
  const factory UserRequest({
    required String displayName,
    required String email,
    required String id,
    required String photoUrl,
    String? serverAuthCode,
    String? fcmToken,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, dynamic> json) => _$UserRequestFromJson(json);
}
