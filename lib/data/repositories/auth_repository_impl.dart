import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/oauth_data_source.dart';
import 'package:tripStory/data/mappers/user_mapper.dart';
import 'package:tripStory/data/models/apple_login_request.dart';
import 'package:tripStory/data/models/user_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final OauthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  ResultFuture<UserEntity> loginWithKakao({
    required String kakaoToken,
    required String fcmToken,
  }) async {
    try {
      final response = await dataSource.fetchKakaoUserInfo(
        kakaoToken,
        fcmToken,
      );
      final entity = UserMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<UserEntity> loginWithGoogle(UserRequest request) async {
    try {
      final response = await dataSource.postGoogleUserInfo(request);
      final entity = UserMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<UserEntity> loginWithApple(AppleLoginRequest request) async {
    try {
      final response = await dataSource.postAppleUserInfo(request);
      final entity = UserMapper.toEntity(response);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
