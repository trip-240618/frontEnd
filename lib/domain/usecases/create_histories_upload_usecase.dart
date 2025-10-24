import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/enum/file_prefix_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/util/extension/either_extension.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/histories_create_entity.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class HistoryUploadWithFile {
  final HistoryUploadEntity historyItem;
  final Uint8List fileBytes;

  const HistoryUploadWithFile({
    required this.historyItem,
    required this.fileBytes,
  });
}

class CreateHistoriesUploadParams {
  final int tripId;
  final List<HistoryUploadWithFile> items;

  const CreateHistoriesUploadParams({
    required this.tripId,
    required this.items,
  });
}

class CreateHistoriesUploadUsecase implements UseCase<List<HistoriesEntity>, CreateHistoriesUploadParams> {
  final TripRepository repository;
  final FileRepository _fileRepository;

  CreateHistoriesUploadUsecase(this.repository, this._fileRepository);

  @override
  ResultFuture<List<HistoriesEntity>> call(CreateHistoriesUploadParams params) async {
    final preUrlsResult = await _fileRepository.fetchFileUrls(
      prefix: FilePrefixType.history.name,
      count: params.items.length,
    );

    return preUrlsResult.fold(
      (failure) => Left(failure),
      (preUrls) async {
        final uploadResults = await Future.wait(
          params.items.asMap().entries.map(
            (entry) async {
              final index = entry.key;
              final item = entry.value;
              final preSignedUrl = preUrls.preSignedUrls[index];
              // TODO : 압축할 이미지를 보내야 하는지? 그럼 presignUrl을 두개 요청 해야 함
              // final compressedBytes = await ImageFileUtil.compressBytes(item.fileBytes);

              final uploadResult = await _fileRepository.uploadBytes(
                preSignedUrl: preSignedUrl,
                bytes: item.fileBytes,
              );

              return uploadResult.map(
                (_) => item.historyItem.copyWith(
                  imageUrl: Uri.parse(preSignedUrl).path,
                  thumbnail: Uri.parse(preSignedUrl).path,
                ),
              );
            },
          ),
        );

        final fail = uploadResults.firstWhereOrNull((result) => result.isLeft());
        if (fail != null) return Left(fail.leftOrNull()!);

        final uploadedEntities =
            uploadResults.map((right) => right.rightOrNull()).whereType<HistoryUploadEntity>().toList();

        final historiesCreateEntity = HistoriesCreateEntity(
          tripId: params.tripId,
          historyItems: uploadedEntities,
        );

        return repository.postCreateManyHistory(
          historiesCreateEntity: historiesCreateEntity,
        );
      },
    );
  }
}
