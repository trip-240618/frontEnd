import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/flight_data_source.dart';
import 'package:tripStory/data/mappers/flight_mapper.dart';
import 'package:tripStory/data/models/request/flight_request.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightDataSource _flightDataSource;

  FlightRepositoryImpl(this._flightDataSource);

  @override
  ResultFuture<FlightEntity> fetchSearchFlight(
    int flightNumber,
    String carrierCode,
    String departureDate,
  ) async {
    try {
      final response = await _flightDataSource.fetchSearchFlight(
        flightNumber: flightNumber,
        carrierCode: carrierCode,
        departureDate: departureDate,
      );
      final entity = FlightMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<FlightEntity> postCreateFlight(
    int tripId,
    FlightRequest request,
  ) async {
    try {
      final response = await _flightDataSource.postCreateFlight(
        tripId: tripId,
        request: request,
      );
      final entity = FlightMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<FlightEntity>> fetchFlight(
    int tripId,
  ) async {
    try {
      final response = await _flightDataSource.fetchFlight(tripId: tripId);
      final entities = response.map(FlightMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteFlight(
    int tripId,
    int flightId,
  ) async {
    try {
      await _flightDataSource.deleteFlight(
        tripId: tripId,
        flightId: flightId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
