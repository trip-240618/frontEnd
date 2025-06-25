import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/country_data_source.dart';
import 'package:tripStory/data/mappers/visited_country_mapper.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';
import 'package:tripStory/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryDataSource dataSource;

  CountryRepositoryImpl(this.dataSource);

  @override
  ResultFuture<List<VisitedCountryEntity>> fetchVisitedCountry() async {
    try {
      final result = await dataSource.fetchVisitedCountry();
      final entity = result.map(VisitedCountryMapper.toEntity).toList();
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
