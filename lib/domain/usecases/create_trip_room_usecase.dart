import 'package:dartz/dartz.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/util/extension/either_extension.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class CreateTripRoomParams {
  final String name;
  final TripType tripType;
  final String startDate;
  final String endDate;
  final String country;
  final List<int>? thumbnailBytes;
  final String color;

  const CreateTripRoomParams({
    required this.name,
    required this.tripType,
    required this.startDate,
    required this.endDate,
    required this.country,
    this.thumbnailBytes,
    required this.color,
  });
}

class CreateTripRoomUseCase implements UseCase<TripRoomCreateEntity, CreateTripRoomParams> {
  final TripRepository _tripRepository;
  final FileRepository _fileRepository;

  CreateTripRoomUseCase(
    this._tripRepository,
    this._fileRepository,
  );

  @override
  ResultFuture<TripRoomCreateEntity> call(CreateTripRoomParams params) async {
    String? thumbnailUrl;

    if (params.thumbnailBytes != null) {
      final preUrl = await _fileRepository.fetchFileUrls(
        prefix: "profile",
        count: 1,
      );
      final preFail = preUrl.leftOrNull();
      if (preFail != null) return Left(preFail);

      final preSignedUrls = preUrl.rightOrNull();
      final preSignedUrl = preSignedUrls?.preSignedUrls.first ?? "";

      final upload = await _fileRepository.uploadBytes(
        preSignedUrl: preSignedUrl,
        bytes: params.thumbnailBytes!,
      );
      final uploadFail = upload.leftOrNull();
      if (uploadFail != null) return Left(uploadFail);
      thumbnailUrl = Uri.parse(preSignedUrl).path;
    }

    return await _tripRepository.postCreateTrip(
      name: params.name,
      tripType: params.tripType.name,
      startDate: params.startDate,
      endDate: params.endDate,
      color: params.color,
      country: params.country,
      thumbnail: thumbnailUrl,
    );
  }
}
