import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/trip_location_data_source.dart';
import 'package:tripStory/data/mappers/auto_location_mapper.dart';
import 'package:tripStory/data/mappers/location_mapper.dart';
import 'package:tripStory/data/models/request/location_auto_request.dart';
import 'package:tripStory/domain/entities/auto_location_entity.dart';
import 'package:tripStory/domain/entities/location_entity.dart';
import 'package:tripStory/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final TripLocationDataSource _tripLocationDataSource;

  LocationRepositoryImpl(this._tripLocationDataSource);

  @override
  ResultFuture<List<AutoLocationEntity>> postAutoComplete(
    LocationAutoRequest request,
  ) async {
    try {
      final result = await _tripLocationDataSource.postAutoComplete(
        request,
      );
      final entities = result.map(AutoLocationMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<LocationEntity> fetchPlaceDetail(
    String placeId,
  ) async {
    try {
      final result = await _tripLocationDataSource.fetchPlaceDetail(placeId);
      final entities = LocationMapper.toEntity(result);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
