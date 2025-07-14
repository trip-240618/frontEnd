import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/notice_list_entity.dart';
import 'package:tripStory/domain/repositories/notice_repository.dart';

class FetchNoticesUsecase implements UseCase<List<NoticeListEntity>, String> {
  final NoticeRepository repository;

  FetchNoticesUsecase(this.repository);

  @override
  ResultFuture<List<NoticeListEntity>> call(String type) async {
    return repository.fetchNotices(type: type);
  }
}
