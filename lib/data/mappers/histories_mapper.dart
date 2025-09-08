import 'package:tripStory/data/models/response/histories_response.dart';
import 'package:tripStory/data/models/response/history_response.dart';
import 'package:tripStory/data/models/response/tag_response.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';

class HistoriesMapper {
  static HistoriesEntity fromResponse(HistoriesResponse response) {
    return HistoriesEntity(
      photoDate: response.photoDate,
      historyList: response.historyList.map(_mapHistoryResponse).toList(),
    );
  }

  static HistoryEntity _mapHistoryResponse(HistoryResponse response) {
    return HistoryEntity(
      id: response.id,
      writerUuid: response.writerUuid,
      nickname: response.nickname,
      profileImage: response.profileImage,
      thumbnail: response.thumbnail,
      imageUrl: response.imageUrl,
      latitude: response.latitude,
      longitude: response.longitude,
      memo: response.memo,
      like: response.like,
      likeCnt: response.likeCnt,
      replyCnt: response.replyCnt,
      photoDate: response.photoDate,
      tags: response.tags?.map(_mapTagResponse).toList(),
    );
  }

  static TagEntity _mapTagResponse(TagResponse response) {
    return TagEntity(
      id: response.id,
      tagColor: response.tagColor,
      tagName: response.tagName,
    );
  }

  static List<HistoriesEntity> fromResponseList(List<HistoriesResponse> responses) {
    return responses.map(fromResponse).toList();
  }
}
