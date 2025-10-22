import 'package:tripStory/data/models/response/history_reply_response.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';

class ReplyMapper {
  static HistoryReplyEntity fromEntity(HistoryReplyResponse response) {
    return HistoryReplyEntity(
      id: response.id,
      writerUuid: response.writerUuid,
      profileImage: response.profileImage,
      nickname: response.nickname,
      createDate: DateTime.parse(response.createDate),
      modifiedDate: DateTime.parse(response.modifiedDate),
      content: response.content,
    );
  }
}
