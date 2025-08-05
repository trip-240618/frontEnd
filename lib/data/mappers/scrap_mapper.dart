import 'package:tripStory/data/models/response/scrap_response.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';

class ScrapMapper {
  static ScrapEntity toEntity(
    ScrapResponse response,
  ) {
    return ScrapEntity(
      id: response.id,
      writerUuid: response.writerUuid,
      nickname: response.nickname,
      title: response.title,
      preview: response.preview,
      hasImage: response.hasImage,
      color: response.color,
      bookmark: response.bookmark,
      createDate: DateTime.parse(response.createDate),
    );
  }
}
