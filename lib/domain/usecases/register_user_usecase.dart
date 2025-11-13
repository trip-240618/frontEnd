import 'package:dartz/dartz.dart';
import 'package:tripStory/core/enum/file_prefix_type.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/util/extension/either_extension.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class RegisterUserParams {
  final String nickname;
  final List<int>? thumbnailBytes;
  final List<int>? profileBytes;
  final bool isMarketing;

  const RegisterUserParams({
    required this.nickname,
    this.thumbnailBytes,
    this.profileBytes,
    required this.isMarketing,
  });
}

class RegisterUserUsecase implements UseCase<UserEntity, RegisterUserParams> {
  final UserRepository _repository;
  final FileRepository _fileRepository;

  RegisterUserUsecase(
    this._repository,
    this._fileRepository,
  );

  @override
  ResultFuture<UserEntity> call(RegisterUserParams params) async {
    String? thumbnailUrl;
    String? profileUrl;

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

    return await _repository.putUserRegister(
      nickname: params.nickname,
      thumbnail: thumbnailUrl,
      profileImg: profileUrl,
      isMarketing: params.isMarketing,
    );
  }
}
