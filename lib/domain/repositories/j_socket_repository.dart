import 'package:tripStory/domain/entities/j_socket_entity.dart';

abstract class JSocketRepository {
  Future<void> connectToTrip(int tripId);

  void disconnect();

  void send(String destination, {String? body});

  Stream<JSocketEntity> listenToPlans(int tripId);
}
