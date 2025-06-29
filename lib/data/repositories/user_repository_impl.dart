import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/user_data_source.dart';
import 'package:tripStory/data/mappers/user_mapper.dart';
import 'package:tripStory/data/models/register_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  ResultFuture<UserEntity> putUserRegister(RegisterRequest request) async {
    try {
      final result = await _userDataSource.putUserRegister(request);
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
}
