import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/services/login_user_service.dart';
import 'package:tripStory/core/services/session_service.dart';
import 'package:tripStory/data/datasources/local/share_preferences_token_storage.dart';
import 'package:tripStory/data/datasources/local/token_storage.dart';
import 'package:tripStory/data/datasources/remote/country_data_source.dart';
import 'package:tripStory/data/datasources/remote/file_data_source.dart';
import 'package:tripStory/data/datasources/remote/notification_data_source.dart';
import 'package:tripStory/data/datasources/remote/oauth_data_source.dart';
import 'package:tripStory/data/datasources/remote/trip_data_source.dart';
import 'package:tripStory/data/datasources/remote/user_data_source.dart';
import 'package:tripStory/data/network/dio_client.dart';
import 'package:tripStory/data/repositories/auth_repository_impl.dart';
import 'package:tripStory/data/repositories/country_repository_impl.dart';
import 'package:tripStory/data/repositories/file_repository_impl.dart';
import 'package:tripStory/data/repositories/notification_repository_impl.dart';
import 'package:tripStory/data/repositories/trip_repository_impl.dart';
import 'package:tripStory/data/repositories/user_repository_impl.dart';
import 'package:tripStory/domain/repositories/auth_repository.dart';
import 'package:tripStory/domain/repositories/country_repository.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // TokenStorage
    Get.put<TokenStorage>(SharedPreferencesTokenStorage(), permanent: true);

    // service
    Get.put<LoginUserService>(LoginUserService(), permanent: true);
    Get.put<SessionService>(
        SessionService(
          Get.find<TokenStorage>(),
          Get.find<LoginUserService>(),
        ),
        permanent: true);

    // DioClient
    Get.put<DioClient>(DioClient(sessionService: Get.find<SessionService>()), permanent: true);
    Get.put<Dio>(Get.find<DioClient>().dio, permanent: true);

    // DataSource
    Get.lazyPut<UserDataSource>(() => UserDataSource(Get.find<Dio>()), fenix: true);
    Get.lazyPut<TripDataSource>(() => TripDataSource(Get.find<Dio>()), fenix: true);
    Get.lazyPut<FileDataSource>(() => FileDataSource(Get.find<Dio>()), fenix: true);
    Get.lazyPut<NotificationDataSource>(() => NotificationDataSource(Get.find<Dio>()), fenix: true);
    Get.lazyPut<OauthDataSource>(() => OauthDataSource(Get.find<Dio>()), fenix: true);
    Get.lazyPut<CountryDataSource>(() => CountryDataSource(Get.find<Dio>()), fenix: true);

    // Repository
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find<UserDataSource>()), fenix: true);
    Get.lazyPut<TripRepository>(() => TripRepositoryImpl(Get.find<TripDataSource>()), fenix: true);
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl(Get.find<FileDataSource>()), fenix: true);
    Get.lazyPut<NotificationRepository>(() => NotificationRepositoryImpl(Get.find<NotificationDataSource>()),
        fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<OauthDataSource>()), fenix: true);
    Get.lazyPut<CountryRepository>(() => CountryRepositoryImpl(Get.find<CountryDataSource>()), fenix: true);
  }
}
