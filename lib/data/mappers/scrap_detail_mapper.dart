import 'package:tripStory/data/models/response/scrap_detail_response.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';

class ScrapDetailMapper {
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
        imageDtos: response.imageDtos);
  }
}
