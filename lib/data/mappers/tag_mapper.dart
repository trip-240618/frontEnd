import 'package:tripStory/data/models/response/tag_response.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';

class TagMapper {
  static TagEntity fromEntity(TagResponse response) {
    return TagEntity(
      id: response.id,
      tagName: response.tagName,
      tagColor: response.tagColor,
    );
  }
}
