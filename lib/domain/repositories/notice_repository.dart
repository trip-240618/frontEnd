import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/notice_list_entity.dart';

abstract class NoticeRepository {
  ResultFuture<List<NoticeListEntity>> fetchNotices({
    required String type,
  });
}
