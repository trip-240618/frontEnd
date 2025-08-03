import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/trip_data_source.dart';
import 'package:tripStory/data/mappers/scrap_create_mapper.dart';
import 'package:tripStory/data/mappers/scrap_mapper.dart';
import 'package:tripStory/data/mappers/trip_room_create_mapper.dart';
import 'package:tripStory/data/mappers/trip_room_mapper.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/domain/entities/scrap_create_entity.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripDataSource _tripDataSource;

  TripRepositoryImpl(this._tripDataSource);

  @override
  ResultFuture<List<TripRoomEntity>> fetchComingTrips() async {
    try {
      final result = await _tripDataSource.inComingTripGet();
      final entities = result.map(TripRoomMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<TripRoomEntity>> fetchLastTrips() async {
    try {
      final result = await _tripDataSource.lastTripGet();
      final entities = result.map(TripRoomMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<TripRoomEntity>> fetchBookmarkedTrips() async {
    try {
      final result = await _tripDataSource.bookMarkTripGet();
      final entities = result.map(TripRoomMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> updateBookmark(int tripId) async {
    try {
      final updated = await _tripDataSource.updateBookMark(tripId);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TripRoomCreateEntity> postCreateTrip(
    TripRoomCreateRequest tripRoomCreateRequest,
  ) async {
    try {
      final response =
          await _tripDataSource.postCreateTrip(tripRoomCreateRequest);
      final entity = TripRoomCreateMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TripRoomEntity> getEnterTrip({required int tripId}) async {
    try {
      final result = await _tripDataSource.getEnterTrip(tripId);
      final entity = TripRoomMapper.toEntity(result);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TripRoomEntity> fetchJoinTrip({
    required String invitationCode,
  }) async {
    try {
      final result = await _tripDataSource.fetchJoinTrip(invitationCode);
      final entity = TripRoomMapper.toEntity(result);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<ScrapEntity>> fetchScraps({required int tripId}) async {
    try {
      final result = await _tripDataSource.fetchScraps(tripId);
      final entity = result.map(ScrapMapper.toEntity).toList();
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<ScrapDetailEntity> createScrap({
    required int tripId,
    required ScrapCreateEntity scrapCreateEntity,
  }) async {
    try {
      final request = ScrapCreateMapper.toRequest(scrapCreateEntity);
      final response = await _tripDataSource.createScrap(tripId, request);
      final entity = ScrapCreateMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
