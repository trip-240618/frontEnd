import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';

abstract class JSocketRepository {
  ResultFuture<void> connectToTrip(int tripId);

  ResultFuture<void> disconnect();

  void send(String destination, {String? body});

  Stream<JSocketEntity> listenToPlans(int tripId);
}
