import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/user_data_source.dart';
import 'package:tripStory/data/mappers/user_mapper.dart';
import 'package:tripStory/data/models/request/register_request.dart';
import 'package:tripStory/data/models/request/user_modify_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  ResultFuture<UserEntity> putUserRegister({
    required String nickname,
    String? thumbnail,
    String? profileImg,
    required bool isMarketing,
  }) async {
    try {
      final registerRequest = RegisterRequest(
        nickname: nickname,
        thumbnail: thumbnail,
        profileImg: profileImg,
        marketing: isMarketing,
      );
      final result = await _userDataSource.putUserRegister(registerRequest);
      final entities = UserMapper.toEntity(result);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<UserEntity> fetchUserInfo() async {
    try {
      final result = await _userDataSource.fetchUserInfo();
      final entities = UserMapper.toEntity(result);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteUser() async {
    try {
      await _userDataSource.deleteUser();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<UserEntity> putUserModify({
    required String nickname,
    required String memo,
    String? thumbnail,
    String? profileImg,
  }) async {
    try {
      final userModifyRequest = UserModifyRequest(
        nickname: nickname,
        memo: memo,
        thumbnail: thumbnail,
        profileImg: profileImg,
      );
      final result = await _userDataSource.putUserModify(userModifyRequest);
      final entities = UserMapper.toEntity(result);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> updateFcmToken({
    required String fcmToken,
  }) async {
    try {
      await _userDataSource.updateFcmToken(fcmToken);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
