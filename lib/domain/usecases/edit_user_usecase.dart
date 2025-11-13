import 'package:dartz/dartz.dart';
import 'package:tripStory/core/enum/file_prefix_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/util/extension/either_extension.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class EditUserParams {
  final String nickname;
  final String memo;
  final String? thumbnail;
  final String? profile;
  final List<int>? thumbnailBytes;
  final List<int>? profileBytes;

  const EditUserParams({
    required this.nickname,
    required this.memo,
    this.thumbnail,
    this.profile,
    this.thumbnailBytes,
    this.profileBytes,
  });
}

class EditUserUsecase implements UseCase<UserEntity, EditUserParams> {
  final UserRepository repository;
  final FileRepository _fileRepository;

  EditUserUsecase(
    this.repository,
    this._fileRepository,
  );

  @override
  ResultFuture<UserEntity> call(EditUserParams params) async {
    String? thumbnailUrl = params.thumbnail;
    String? profileUrl = params.profile;

    if (params.thumbnailBytes != null) {
      final preUrl = await _fileRepository.fetchFileUrls(
        prefix: FilePrefixType.profile.name,
        count: 2,
      );
      final preFail = preUrl.leftOrNull();
      if (preFail != null) return Left(preFail);

      final preSignedUrls = preUrl.rightOrNull();
      final thumbPreSignedUrl = preSignedUrls?.preSignedUrls[0] ?? "";
      final profilePreSignedUrl = preSignedUrls?.preSignedUrls[1] ?? "";

      await Future.wait([
        _fileRepository.uploadBytes(
          preSignedUrl: thumbPreSignedUrl,
          bytes: params.thumbnailBytes!,
        ),
        _fileRepository.uploadBytes(
          preSignedUrl: profilePreSignedUrl,
          bytes: params.profileBytes!,
        ),
      ]);
      thumbnailUrl = Uri.parse(thumbPreSignedUrl).path;
      profileUrl = Uri.parse(profilePreSignedUrl).path;
    }

    return await repository.putUserModify(
      nickname: params.nickname,
      memo: params.memo,
      thumbnail: thumbnailUrl,
      profileImg: profileUrl,
    );
  }
}
