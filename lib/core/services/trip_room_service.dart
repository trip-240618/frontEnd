import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

class TripRoomService extends GetxService {
  TripRoomEntity? _tripRoomEntity;

  TripRoomEntity? get tripRoomEntity => _tripRoomEntity;

  void setTripRoom(TripRoomEntity room) {
    _tripRoomEntity = room;
  }

  void clear() {
    _tripRoomEntity = null;
  }
// final _tripRoom = Rxn<TripRoom>();
//
// TripRoom? get tripRoom => _tripRoom.value;
//
// bool get hasRoom => _tripRoom.value != null;
//
// Future<void> fetchTripRoom(int tripId) async {
//   try {
//     // 실제 API 호출 (Dio 등 활용)
//     final response = await dio.get('/trip/$tripId');
//     final room = TripRoom.fromJson(response.data);
//     _tripRoom.value = room;
//   } catch (e) {
//     print("Failed to fetch trip room: $e");
//     rethrow;
//   }
// }
//
// void clear() {
//   _tripRoom.value = null;
// }
}
