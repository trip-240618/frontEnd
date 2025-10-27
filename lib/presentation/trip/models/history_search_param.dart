import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

part 'history_search_param.freezed.dart';

@freezed
sealed class HistorySearchParam with _$HistorySearchParam {
  const HistorySearchParam._();

  const factory HistorySearchParam.tag({
    required TagEntity tag,
  }) = TagSearchParam;

  const factory HistorySearchParam.member({
    required TripMemberEntity member,
  }) = MemberSearchParam;
}
