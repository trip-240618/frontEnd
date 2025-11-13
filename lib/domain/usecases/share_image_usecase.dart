import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';

class ShareImageUsecase implements UseCase<void, String> {
  final FileRepository repository;

  ShareImageUsecase(this.repository);

  @override
  ResultFuture<void> call(String imageUrl) {
    return repository.shareImage(
      imageUrl: imageUrl,
    );
  }
}
