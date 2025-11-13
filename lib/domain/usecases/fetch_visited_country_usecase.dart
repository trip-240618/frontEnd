import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';
import 'package:tripStory/domain/repositories/country_repository.dart';

class FetchVisitedCountryUsecase implements UseCase<List<VisitedCountryEntity>, NoParams> {
  final CountryRepository repository;

  FetchVisitedCountryUsecase(this.repository);

  @override
  ResultFuture<List<VisitedCountryEntity>> call(NoParams params) async {
    return await repository.fetchVisitedCountry();
  }
}
