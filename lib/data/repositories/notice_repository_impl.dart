import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/notice_data_source.dart';
import 'package:tripStory/data/mappers/notice_list_mapper.dart';
import 'package:tripStory/domain/entities/notice_list_entity.dart';
import 'package:tripStory/domain/repositories/notice_repository.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDataSource _noticeDataSource;

  NoticeRepositoryImpl(this._noticeDataSource);

  @override
  ResultFuture<List<NoticeListEntity>> fetchNotices({
    required String type,
  }) async {
    try {
      final result = await _noticeDataSource.fetchNotices(
        type,
      );
      final entities = result.map(NoticeListMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
