import 'dart:async';

import 'package:tripStory/core/services/socket_service.dart';
import 'package:tripStory/data/mappers/j_socket_mapper.dart';
import 'package:tripStory/data/models/response/socket_response.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';

class JSocketRepositoryImpl implements JSocketRepository {
  final SocketService _socketService;
  final _controller = StreamController<JSocketEntity>.broadcast();

  JSocketRepositoryImpl(this._socketService);

  @override
  Future<void> connectToTrip(int tripId) async {
    await _socketService.connect(tripId: tripId);
    _socketService.subscribe("/topic/api/trip/j/$tripId");

    _socketService.messageStream.listen((data) {
      final socketResponse = SocketResponse.fromJson(data);
      final entity = JSocketMapper.toEntity(socketResponse);
      if (entity != null) {
        _controller.add(entity);
      }
    });
  }

  @override
  void disconnect() {
    _socketService.disconnect();
    _controller.close();
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
