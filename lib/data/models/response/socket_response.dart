import 'package:freezed_annotation/freezed_annotation.dart';

part 'socket_response.freezed.dart';
part 'socket_response.g.dart';

// todo : sealed class로 변경
@freezed
abstract class SocketResponse with _$SocketResponse {
  const factory SocketResponse({
    required String command,
    required Map<String, dynamic> data,
  }) = _SocketResponse;

  factory SocketResponse.fromJson(Map<String, dynamic> json) => _$SocketResponseFromJson(json);
}
