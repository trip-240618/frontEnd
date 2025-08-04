import 'package:freezed_annotation/freezed_annotation.dart';

part 'j_plan_register_response.freezed.dart';
part 'j_plan_register_response.g.dart';

@freezed
abstract class JPlanRegisterResponse with _$JPlanRegisterResponse {
  const factory JPlanRegisterResponse({
    required int day,
    required String editorUuid,
    required String nickname,
  }) = _JPlanRegisterResponse;

  factory JPlanRegisterResponse.fromJson(Map<String, dynamic> json) => _$JPlanRegisterResponseFromJson(json);
}
