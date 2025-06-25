import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';

abstract class CountryRepository {
  ResultFuture<List<VisitedCountryEntity>> fetchVisitedCountry();
}
