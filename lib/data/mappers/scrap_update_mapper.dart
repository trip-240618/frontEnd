import 'package:tripStory/data/models/request/scrap_modify_request.dart';
import 'package:tripStory/data/models/response/scrap_detail_response.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/entities/scrap_update_entity.dart';

class ScrapUpdateMapper {
  static ScrapModifyRequest toRequest(ScrapUpdateEntity entity) {
    return ScrapModifyRequest(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      hasImage: entity.hasImage,
      color: entity.color,
      photoList: entity.photoList,
    );
  }

  static ScrapDetailEntity toEntity(ScrapDetailResponse response) {
    return ScrapDetailEntity(
      id: response.id,
      writerUuid: response.writerUuid,
      nickname: response.nickname,
      title: response.title,
      content: response.content,
      hasImage: response.hasImage,
      color: response.color,
      bookmark: response.bookmark,
      createDate: response.createDate,
      imageDtos: response.imageDtos,
    );
  }
}
