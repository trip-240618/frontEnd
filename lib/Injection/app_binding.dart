import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tripStory/data/datasources/remote/file_data_source.dart';
import 'package:tripStory/data/datasources/remote/notification_data_source.dart';
import 'package:tripStory/data/datasources/remote/trip_data_source.dart';
import 'package:tripStory/data/network/dio_client.dart';
import 'package:tripStory/data/repositories/file_repository_impl.dart';
import 'package:tripStory/data/repositories/notification_repository_impl.dart';
import 'package:tripStory/data/repositories/trip_repository_impl.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final dioClient = DioClient();
    Get.put<Dio>(dioClient.dio, permanent: true);

    //data
    Get.lazyPut<TripDataSource>(() => TripDataSource(Get.find<Dio>()));
    Get.lazyPut<FileDataSource>(() => FileDataSource(Get.find<Dio>()));
    Get.lazyPut<NotificationDataSource>(
      () => NotificationDataSource(Get.find<Dio>()),
      fenix: true,
    );
    //repository
    Get.lazyPut<TripRepository>(() => TripRepositoryImpl(Get.find<TripDataSource>()));
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl(Get.find<FileDataSource>()));
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepositoryImpl(Get.find<NotificationDataSource>()),
      fenix: true,
    );
  }
}
