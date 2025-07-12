import 'package:tripStory/data/models/response/notice_list_response.dart';
import 'package:tripStory/domain/entities/notice_list_entity.dart';
import 'package:tripStory/util/extension/string_extension.dart';

class NoticeListMapper {
  static NoticeListEntity toEntity(NoticeListResponse response) {
    return NoticeListEntity(
      title: response.title,
      id: response.id,
      type: response.type,
      createDate: response.createDate.toDateTime(),
    );
  }
}
