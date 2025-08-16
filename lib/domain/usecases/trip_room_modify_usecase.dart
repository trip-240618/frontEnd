import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class ModifyTripRoomParams {
  final int id;
  final TripRoomEntity entity;
  final List<int>? thumbnailBytes;
  final void Function(int sent, int total)? onProgress;

  const ModifyTripRoomParams({
    required this.id,
    required this.entity,
    this.thumbnailBytes,
    this.onProgress,
  });
}

class TripRoomModifyUsecase implements UseCase<TripRoomEntity, ModifyTripRoomParams> {
  final TripRepository repository;
  final FileRepository fileRepository;

  TripRoomModifyUsecase(
    this.repository,
    this.fileRepository,
  );

  @override
  ResultFuture<TripRoomEntity> call(ModifyTripRoomParams params) async {
    if (params.thumbnailBytes == null) {
      return repository.putModifyTripRoom(
        tripId: params.id,
        tripRoomEntity: params.entity,
      );
    }

    final preUrl = await fileRepository.fetchFileUrls(
      prefix: "profile",
      count: 1,
    );

    return preUrl.fold(
      (failure) => Left(failure),
      (imageUrls) async {
        final imageUrl = imageUrls.preSignedUrls.first;
        final upload = await fileRepository.uploadBytes(
          preSignedUrl: imageUrl,
          bytes: params.thumbnailBytes!,
          onSendProgress: params.onProgress,
        );
        return upload.fold(
          (failure) => Left(failure),
          (_) => repository.putModifyTripRoom(
            tripId: params.id,
            tripRoomEntity: params.entity.copyWith(
              thumbnail: Uri.parse(imageUrl).path,
            ),
          ),
        );
      },
    );
  }
}
