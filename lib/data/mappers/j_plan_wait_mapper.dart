import 'package:tripStory/data/models/response/j_plan_register_response.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

class JPlanWaitMapper {
  static JSocketEntity toEntity(JPlanRegisterResponse response) {
    return PlanWait(
      day: response.day,
      editorUuid: response.editorUuid,
      nickname: response.nickname,
    );
  }
}
