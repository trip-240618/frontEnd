import 'package:tripStory/core/util/helper/country_flag_helper.dart';
import 'package:tripStory/data/models/response/country_visited_response.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';

class VisitedCountryMapper {
  static VisitedCountryEntity toEntity(CountryVisitedResponse response) {
    return VisitedCountryEntity(
        country: response.country,
        visitCnt: response.visitCnt,
        imageUrl: CountryFlagHelper.getImageUrlByName(response.country));
  }
}
