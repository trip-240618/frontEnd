import 'package:dartz/dartz.dart';
import 'package:tripStory/core/constants/network_constants.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/trip_data_source.dart';
import 'package:tripStory/data/mappers/j_plan_mapper.dart';
import 'package:tripStory/data/mappers/scrap_create_mapper.dart';
import 'package:tripStory/data/mappers/scrap_detail_mapper.dart';
import 'package:tripStory/data/mappers/scrap_mapper.dart';
import 'package:tripStory/data/mappers/scrap_update_mapper.dart';
import 'package:tripStory/data/mappers/trip_room_create_mapper.dart';
import 'package:tripStory/data/mappers/trip_room_mapper.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_modify_request.dart';
import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/data/network/socket_service.dart';
import 'package:tripStory/domain/entities/j_plan_entity.dart';
import 'package:tripStory/domain/entities/scrap_create_entity.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/entities/scrap_entity.dart';
import 'package:tripStory/domain/entities/scrap_update_entity.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripDataSource _tripDataSource;
  final SocketService _socketService;

  TripRepositoryImpl(
    this._tripDataSource,
    this._socketService,
  );

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
      final response = await _tripDataSource.postCreateTrip(tripRoomCreateRequest);
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
  ResultFuture<List<ScrapEntity>> fetchScraps({
    required int tripId,
  }) async {
    try {
      final result = await _tripDataSource.fetchScraps(tripId);
      final entity = result.map(ScrapMapper.toEntity).toList();
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<ScrapEntity>> fetchBookmarkedScraps({
    required int tripId,
  }) async {
    try {
      final result = await _tripDataSource.fetchBookmarkedScraps(tripId);
      final entity = result.map(ScrapMapper.toEntity).toList();
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> toggleScrapBookmark({
    required int tripId,
    required int scrapId,
  }) async {
    try {
      final result = await _tripDataSource.toggleScrapBookmark(tripId, scrapId);
      return Right(result);
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

  @override
  ResultFuture<ScrapDetailEntity> updateScrap({
    required int tripId,
    required ScrapUpdateEntity scrapUpdateEntity,
  }) async {
    try {
      final request = ScrapUpdateMapper.toRequest(scrapUpdateEntity);
      final response = await _tripDataSource.updateScrap(tripId, request);
      final entity = ScrapUpdateMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteScrap({
    required int tripId,
    required int scrapId,
  }) async {
    try {
      await _tripDataSource.deleteScrap(tripId, scrapId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<ScrapDetailEntity> fetchScrapDetail({required int tripId, required int scrapId}) async {
    try {
      final response = await _tripDataSource.fetchScrapDetail(tripId, scrapId);
      final entity = ScrapDetailMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<JPlanEntity>> fetchJPlan({
    required int tripId,
    required int day,
    required bool locker,
  }) async {
    try {
      final result = await _tripDataSource.fetchJPlan(
        tripId,
        day,
        locker,
      );
      final entities = result.expand((dayPlan) => dayPlan.planList).map(JPlanMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> postCreateJPlan({
    required int tripId,
    required PlanJCreateRequest planJCreateRequest,
  }) async {
    try {
      await _tripDataSource.postCreateJPlan(
        tripId,
        planJCreateRequest,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteJPlan({
    required int tripId,
    required int planId,
    required int day,
  }) async {
    try {
      await _tripDataSource.deleteJPlan(tripId, planId, day);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> putModifyJPlan({
    required int tripId,
    required PlanJModifyRequest request,
  }) async {
    try {
      await _tripDataSource.putModifyJPlan(tripId, request);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> putSwapJPlan({
    required int tripId,
    required PlanJSwapRequest request,
  }) async {
    try {
      await _tripDataSource.putSwapJPlan(tripId, request);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> fetchRegisterJPlan({
    required int tripId,
    required int day,
  }) async {
    try {
      final destination = NetworkConstants.registerJPlan(tripId, day);
      _socketService.send(destination);

      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> fetchRegisterFinishJPlan({
    required int tripId,
    required int day,
  }) async {
    try {
      await _tripDataSource.fetchRegisterFinishJPlan(tripId, day);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
