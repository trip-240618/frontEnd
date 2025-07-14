import 'package:get/get.dart';
import 'package:tripStory/view/trip/models/trip_main_state.dart';

class TripMainController extends GetxController {
  TripMainController();

  TripMainState _tripMainState = TripMainState();

  TripMainState get state => _tripMainState;

  void onNaviPressed(int index) {
    _tripMainState = state.copyWith(
      selectedTripType: TripNaviType.values[index],
    );
    update();
  }
}
