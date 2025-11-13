import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/j_socket_entity.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';

class JPlanListenSocketUsecase implements StreamUseCase<JSocketEntity, int> {
  final JSocketRepository repository;

  JPlanListenSocketUsecase(this.repository);

  @override
  Stream<JSocketEntity> call(int tripId) {
    return repository.listenToPlans(tripId);
  }
}
