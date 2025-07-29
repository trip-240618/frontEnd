import 'package:freezed_annotation/freezed_annotation.dart';

part 'j_plan_deleted_response.freezed.dart';
part 'j_plan_deleted_response.g.dart';

@freezed
abstract class JPlanDeletedResponse with _$JPlanDeletedResponse {
  const factory JPlanDeletedResponse({
    required int dayAfterStart,
    required int planId,
  }) = _JPlanDeletedResponse;

  factory JPlanDeletedResponse.fromJson(Map<String, dynamic> json) => _$JPlanDeletedResponseFromJson(json);
}
