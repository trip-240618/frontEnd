import 'package:dartz/dartz.dart';
import 'package:tripStory/core/constants/network_constants.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/trip_data_source.dart';
import 'package:tripStory/data/mappers/histories_mapper.dart';
import 'package:tripStory/data/mappers/j_plan_mapper.dart';
import 'package:tripStory/data/mappers/reply_mapper.dart';
import 'package:tripStory/data/mappers/scrap_create_mapper.dart';
import 'package:tripStory/data/mappers/scrap_detail_mapper.dart';
import 'package:tripStory/data/mappers/scrap_mapper.dart';
import 'package:tripStory/data/mappers/scrap_update_mapper.dart';
import 'package:tripStory/data/mappers/trip_room_create_mapper.dart';
import 'package:tripStory/data/mappers/trip_room_mapper.dart';
import 'package:tripStory/data/models/request/history_reply_request.dart';
import 'package:tripStory/data/models/request/plan_j_create_request.dart';
import 'package:tripStory/data/models/request/plan_j_modify_request.dart';
import 'package:tripStory/data/models/request/plan_j_swap_request.dart';
import 'package:tripStory/data/models/request/trip_room_create_request.dart';
import 'package:tripStory/data/network/socket_service.dart';
import 'package:tripStory/domain/entities/histories_create_entity.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';
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
  ResultFuture<TripRoomCreateEntity> postCreateTrip({
    required String name,
    required String tripType,
    required String startDate,
    required String endDate,
    required String color,
    required String country,
    String? thumbnail,
  }) async {
    try {
      final tripRoomCreateRequest = TripRoomCreateRequest(
        name: name,
        type: tripType,
        startDate: startDate,
        endDate: endDate,
        country: country,
        thumbnail: thumbnail,
        labelColor: color,
      );
      final response = await _tripDataSource.postCreateTrip(tripRoomCreateRequest);
      final entity = TripRoomCreateMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TripRoomEntity> putModifyTripRoom({
    required int tripId,
    required TripRoomEntity tripRoomEntity,
  }) async {
    try {
      final request = TripRoomMapper.toUpdateRequest(tripRoomEntity);
      final result = await _tripDataSource.putModifyTrip(
        tripId,
        request,
      );
      final entity = TripRoomMapper.toEntity(result);
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
  ResultFuture<void> deleteTripRoom({
    required int tripId,
  }) async {
    try {
      await _tripDataSource.deleteTripRoom(tripId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteLeaveTripRoom({
    required String tripType,
    required int tripId,
  }) async {
    try {
      await _tripDataSource.deleteLeaveTripRoom(
        tripType,
        tripId,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteKickMember({
    required int tripId,
    required String tripType,
    required String uuid,
  }) async {
    try {
      await _tripDataSource.deleteKickMember(
        tripId,
        tripType,
        uuid,
      );
      return Right(null);
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
    required int planId,
    required int dayAfterStart,
    int? orderByDate,
    required String startTime,
    required String title,
    String? place,
    String? memo,
    double? latitude,
    double? longitude,
    required bool locker,
  }) async {
    try {
      final request = PlanJModifyRequest(
        planId: planId,
        dayAfterStart: dayAfterStart,
        orderByDate: orderByDate,
        startTime: startTime,
        title: title,
        place: place,
        memo: memo,
        latitude: latitude,
        longitude: longitude,
        locker: locker,
      );

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

  @override
  ResultFuture<List<HistoriesEntity>> fetchHistories({
    required int tripId,
  }) async {
    try {
      final result = await _tripDataSource.fetchHistoryList(tripId);
      final entities = HistoriesMapper.fromResponseList(result);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<HistoryEntity> fetchHistoryDetail({
    required int tripId,
    required int historyId,
  }) async {
    try {
      final result = await _tripDataSource.fetchHistoryDetail(
        tripId,
        historyId,
      );
      final entity = HistoriesMapper.fromHistoryResponse(result);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<HistoriesEntity>> postCreateManyHistory({
    required HistoriesCreateEntity historiesCreateEntity,
  }) async {
    try {
      final requestBody = HistoriesMapper.toRequest(
        historiesCreateEntity.historyItems,
      );

      final result = await _tripDataSource.postCreateManyHistory(
        historiesCreateEntity.tripId,
        requestBody,
      );

      final entities = HistoriesMapper.fromResponseList(result);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<HistoryReplyEntity>> fetchReplies({
    required int tripId,
    required int historyId,
  }) async {
    try {
      final result = await _tripDataSource.fetchReplies(
        tripId,
        historyId,
      );

      final entities = result.map(ReplyMapper.fromEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<HistoryReplyEntity>> postReplyCreate({
    required int tripId,
    required int historyId,
    required String content,
  }) async {
    try {
      final request = HistoryReplyRequest(
        content: content,
      );

      final result = await _tripDataSource.postReplyCreate(
        tripId,
        historyId,
        request,
      );

      final entities = result.map(ReplyMapper.fromEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
