import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/mappers/j_socket_mapper.dart';
import 'package:tripStory/data/models/response/socket_response.dart';
import 'package:tripStory/data/network/socket_service.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';

class JSocketRepositoryImpl implements JSocketRepository {
  final SocketService _socketService;
  final _controller = StreamController<JSocketEntity>.broadcast();
  StreamSubscription? _socketSubscription;

  JSocketRepositoryImpl(this._socketService);

  @override
  ResultFuture<void> connectToTrip(int tripId) async {
    try {
      await _socketService.connect(tripId: tripId);
      _socketService.subscribe("/topic/api/trip/j/$tripId");

      _socketSubscription?.cancel();

      _socketSubscription = _socketService.messageStream.listen((data) {
        final socketResponse = SocketResponse.fromJson(data);
        final entity = JSocketMapper.toEntity(socketResponse);
        if (entity != null) {
          _controller.add(entity);
        }
      });

      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  ResultFuture<void> disconnect() async {
    try {
      _socketService.disconnect();
      await _socketSubscription?.cancel();
      _socketSubscription = null;
      await _controller.close();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  void send(String destination, {String? body}) {
    _socketService.send(destination, body: body);
  }

  @override
  Stream<JSocketEntity> listenToPlans(int tripId) {
    return _controller.stream;
  }
}
