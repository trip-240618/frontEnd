import 'package:tripStory/core/enum/command_type.dart';
import 'package:tripStory/data/mappers/j_plan_add_mapper.dart';
import 'package:tripStory/data/mappers/j_plan_delete_mapper.dart';
import 'package:tripStory/data/mappers/j_plan_modify_mapper.dart';
import 'package:tripStory/data/mappers/j_plan_register_mapper.dart';
import 'package:tripStory/data/mappers/j_plan_swap_mapper.dart';
import 'package:tripStory/data/mappers/j_plan_wait_mapper.dart';
import 'package:tripStory/data/models/response/j_plan_deleted_response.dart';
import 'package:tripStory/data/models/response/j_plan_register_response.dart';
import 'package:tripStory/data/models/response/plan_j_response.dart';
import 'package:tripStory/data/models/response/socket_response.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

class JSocketMapper {
  static JSocketEntity? toEntity(SocketResponse response) {
    final command = CommandType.from(response.command);
    final data = response.data;
    switch (command) {
      case CommandType.create:
        final addResponse = PlanResponse.fromJson(data);
        return JPlanAddMapper.toEntity(addResponse);

      case CommandType.delete:
        final deletedResponse = JPlanDeletedResponse.fromJson(data);
        return JPlanDeleteMapper.toEntity(deletedResponse);

      case CommandType.modify:
        final modifyResponse = PlanResponse.fromJson(data);
        return JPlanModifyMapper.toEntity(modifyResponse);

      case CommandType.register:
        final registerResponse = JPlanRegisterResponse.fromJson(data);
        return JPlanRegisterMapper.toEntity(registerResponse);

      case CommandType.wait:
        final registerResponse = JPlanRegisterResponse.fromJson(data);
        return JPlanWaitMapper.toEntity(registerResponse);

      case CommandType.swap:
        final rawList = data as List<dynamic>;
        final response = PlanJResponse.fromJson(rawList.first);
        return JPlanSwapMapper.toEntity(response);
    }
  }
}
