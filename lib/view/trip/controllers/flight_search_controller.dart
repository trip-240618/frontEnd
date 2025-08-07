import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/entities/air_line_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_flight_result_usecase.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/flight_search_state.dart';

class FlightSearchController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchFlightResultUsecase _fetchFlightResultUsecase;

  FlightSearchController(
    this._tripRoomService,
    this._fetchFlightResultUsecase,
  );

  final List<AirLineEntity> _defaultAirlines = [
    AirLineEntity(name: '대한항공', code: 'KE'),
    AirLineEntity(name: '아시아나항공', code: 'OZ'),
    AirLineEntity(name: '티웨이항공', code: 'TW'),
    AirLineEntity(name: '제주항공', code: '7C'),
    AirLineEntity(name: '진에어', code: 'LJ'),
  ];

  final List<AirLineEntity> _totalAirLine = [
    // 대한민국
    AirLineEntity(name: '대한항공', code: 'KE'),
    AirLineEntity(name: '아시아나항공', code: 'OZ'),
    AirLineEntity(name: '티웨이항공', code: 'TW'),
    AirLineEntity(name: '제주항공', code: '7C'),
    AirLineEntity(name: '진에어', code: 'LJ'),
    AirLineEntity(name: '에어부산', code: 'BX'),
    AirLineEntity(name: '이스타항공', code: 'ZE'),
    AirLineEntity(name: '에어서울', code: 'RS'),
    AirLineEntity(name: '플라이강원', code: '4V'),
    AirLineEntity(name: '하이에어', code: '4H'),
    AirLineEntity(name: '에어인천', code: 'KJ'),
    AirLineEntity(name: '에어로케이항공', code: 'RF'),
    AirLineEntity(name: '에어프레미아', code: 'YP'),
    // 태국
    AirLineEntity(name: '타이항공', code: 'TG'),
    AirLineEntity(name: 'K-Mile 항공', code: '8K'),
    AirLineEntity(name: '녹에어', code: 'DD'),
    AirLineEntity(name: '방콕항공', code: 'PG'),
    AirLineEntity(name: '에어 피플 인터내셔널', code: '3D'),
    AirLineEntity(name: '타이 에어아시아', code: 'FD'),
    AirLineEntity(name: '타이 스마일 항공', code: 'WE'),
    AirLineEntity(name: '제트 아시아 항공', code: 'JF'),
    AirLineEntity(name: '타이 비엣젯 항공', code: 'VZ'),
    // 일본
    AirLineEntity(name: '일본항공', code: 'JL'),
    AirLineEntity(name: '전일본공수', code: 'NH'),
    AirLineEntity(name: '바닐라에어', code: 'JW'),
    AirLineEntity(name: '피치 항공', code: 'MM'),
    AirLineEntity(name: '에어재팬', code: 'NQ'),
    // 중국
    AirLineEntity(name: '중국국제항공', code: 'CA'),
    AirLineEntity(name: '중국남방항공', code: 'CZ'),
    AirLineEntity(name: '중국동방항공', code: 'MU'),
    AirLineEntity(name: '중국해남항공', code: 'HU'),
    AirLineEntity(name: '상하이항공', code: 'FM'),
    AirLineEntity(name: '샤먼항공', code: 'MF'),
    AirLineEntity(name: '춘추항공', code: '9C'),
    AirLineEntity(name: '칭다오항공', code: 'QW'),
    AirLineEntity(name: '캐피탈항공', code: 'JD'),
    AirLineEntity(name: '길상항공(준야오항공)', code: 'HO'),
    // 홍콩
    AirLineEntity(name: '캐세이퍼시픽', code: 'CX'),
    AirLineEntity(name: '캐세이 드래곤', code: 'KA'),
    AirLineEntity(name: '홍콩익스프레스', code: 'UO'),
    // 마카오
    AirLineEntity(name: '에어 마카오', code: 'NX'),
    // 대만
    AirLineEntity(name: '중화항공', code: 'CI'),
    AirLineEntity(name: '에바항공', code: 'BR'),
    // 미국
    AirLineEntity(name: '아메리칸항공', code: 'AA'),
    AirLineEntity(name: '델타항공', code: 'DL'),
    AirLineEntity(name: '유나이티드항공', code: 'UA'),
    AirLineEntity(name: '하와이안 항공', code: 'HA'),
    AirLineEntity(name: '알래스카항공', code: 'AS'),
    AirLineEntity(name: '사우스웨스트항공', code: 'WN'),
    AirLineEntity(name: '버진 아메리카', code: 'VX'),
    // 영국
    AirLineEntity(name: '영국항공', code: 'BA'),
    // 독일
    AirLineEntity(name: '루프트한자', code: 'LH'),
    // 아랍에미리트
    AirLineEntity(name: '에미레이트항공', code: 'EK'),
  ];

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  FlightSearchState _flightSearchState = FlightSearchState();

  FlightSearchState get state => _flightSearchState;

  @override
  void onInit() {
    super.onInit();

    _flightSearchState = state.copyWith(
      airLines: _defaultAirlines,
      departureDate: tripRoomInfo?.startDate,
    );
    update();
  }

  void onDateChanged(
    DateTime selectedDate,
  ) {
    _flightSearchState = state.copyWith(
      departureDate: selectedDate,
    );
    update();
  }

  void onAirLinesPressed(AirLineEntity airLineEntity) {
    _flightSearchState = state.copyWith(
      selectedAirLine: airLineEntity,
    );
    update();
  }

  void onAirLinesSearch(String searchText) {
    final query = searchText.trim().toLowerCase();

    final filteredAirlines = query.isEmpty
        ? _defaultAirlines
        : _totalAirLine.where((airline) {
            return airline.name.toLowerCase().contains(query) || airline.code.toLowerCase().contains(query);
          }).toList();

    _flightSearchState = state.copyWith(
      airLines: filteredAirlines,
    );

    update();
  }

  void onFlightNumberChanged(String number) {
    _flightSearchState = state.copyWith(
      airLineNumber: number,
    );
  }

  Future<void> onBottomPressed() async {
    final params = Tuple3(
      int.parse(state.airLineNumber),
      state.selectedAirLine?.code ?? "",
      state.departureDate?.formatYMDWithHyphen() ?? "",
    );
    final result = await _fetchFlightResultUsecase.call(params);

    result.fold(
      (failure) {
        _flightSearchState = state.copyWith(
          flightSearchStatus: FlightSearchStatus.empty,
        );
        update();
      },
      (flightEntity) {
        _flightSearchState = state.copyWith(
          flightSearchStatus: FlightSearchStatus.success,
        );
        update();
      },
    );
  }
}
