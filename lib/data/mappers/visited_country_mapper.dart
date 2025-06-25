import 'package:tripStory/data/models/country_visited_response.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';
import 'package:tripStory/util/helper/country_flag_helper.dart';

class VisitedCountryMapper {
  static VisitedCountryEntity toEntity(CountryVisitedResponse response) {
    return VisitedCountryEntity(
        country: response.country,
        visitCnt: response.visitCnt,
        imageUrl: CountryFlagHelper.getImageUrlByName(response.country));
  }
}
