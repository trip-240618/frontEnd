import 'package:tripStory/data/models/request/history_create_request.dart';
import 'package:tripStory/data/models/response/histories_response.dart';
import 'package:tripStory/data/models/response/history_response.dart';
import 'package:tripStory/data/models/response/tag_response.dart';
import 'package:tripStory/domain/entities/histories_create_entity.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';

class HistoriesMapper {
  static HistoriesEntity fromResponse(HistoriesResponse response) {
    return HistoriesEntity(
      photoDate: response.photoDate,
      historyList: response.historyList.map(fromHistoryResponse).toList(),
    );
  }

  static HistoryCreateRequest toRequest(List<HistoryUploadEntity> entities) {
    final histories = entities
        .map((history) => HistoryCreateItem(
              thumbnail: history.thumbnail ?? "",
              imageUrl: history.imageUrl ?? "",
              latitude: history.latitude,
              longitude: history.longitude,
              photoDate: history.photoDate,
              tags: history.tags
                  ?.map((tag) => TagResponse(
                        tagName: tag.tagName,
                        tagColor: tag.tagColor,
                      ))
                  .toList(),
            ))
        .toList();

    return HistoryCreateRequest(
      historyCreateRequestDtos: histories,
    );
  }

  static HistoryEntity fromHistoryResponse(HistoryResponse response) {
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
      photoDate: DateTime.parse(response.photoDate),
      tags: response.tags?.whereType<TagResponse>().map(_mapTagResponse).toList(),
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
