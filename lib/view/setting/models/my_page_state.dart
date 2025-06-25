import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/visited_country_entity.dart';

part 'my_page_state.freezed.dart';

@freezed
abstract class MyPageState with _$MyPageState {
  const MyPageState._();

  const factory MyPageState({
    @Default([]) List<VisitedCountryEntity> visitedCountryItems,
  }) = _MyPageState;

  int get visitedCountryCount => visitedCountryItems.length;

  int get domesticCount => visitedCountryItems.where((entry) => entry.country == "대한민국").length;

  int get abroadCount => visitedCountryItems.where((entry) => entry.country != "대한민국").length;
}
