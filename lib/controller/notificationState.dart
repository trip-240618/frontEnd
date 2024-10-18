import 'package:get/get.dart';
import 'package:tripStory/app/api/notiApi.dart';
import 'package:tripStory/app/api/notificationApi.dart';
import '../app/config/dio_client.dart';

class NotiState extends GetxController{
  final selectTabIndex = 0.obs;
  final apiNotificationClient = ApiNotificationClient(DioClient());
  final notificationList = [].obs;
  /// 알림 기록 가져오기
  Future<void> getNotificationList(String title)async{
    notificationList.value = await apiNotificationClient.getNotificationList(title);
    print("?? ${notificationList.length}");
    notificationList.refresh();
  }
}