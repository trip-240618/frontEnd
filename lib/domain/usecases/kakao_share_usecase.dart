import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/services/kakao_share_service.dart';
import 'package:tripStory/domain/base/usecase.dart';

class KakaoShareUsecase implements UseCase<void, Tuple2<int, String>> {
  final KakaoShareService _shareService;

  KakaoShareUsecase(this._shareService);

  @override
  ResultFuture<void> call(Tuple2<int, String> params) async {
    final tripId = params.value1;
    final inviteCode = params.value2;

    try {
      await _shareService.shareTrip(tripId, inviteCode);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
