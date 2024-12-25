import 'package:get/get.dart';
import 'package:tripStory/app/api/notificationApi.dart';
import '../app/api/historyApi.dart';
import '../app/config/dio_client.dart';

class NotiState extends GetxController{
  final selectTabIndex = 0.obs;
  final apiNotificationClient = ApiNotificationClient(DioClient());
  final apiHistoryClient = ApiHistoryClient(DioClient());
  final notificationList = [].obs;
  final notificationHistory = {}.obs; /// 알림에서 들어가는 여행 기록 리스트
  final notificationComment = [].obs; /// 알림에서 들어가는 여행 댓글
  final notificationCount = 0.obs; /// 홈 화면에서 알림이 있냐 없냐
  final notificationIndex = 0.obs; /// 알림에서 노티 인덱스
  /// 알림 기록 가져오기
  Future<List<Map<String, dynamic>>> getNotificationList(String title,int id)async{
    // notificationList.value = await apiNotificationClient.getNotificationList(title,id);
    return await apiNotificationClient.getNotificationList(title,id);
  }
  /// 홈 화면 용 알림 확인
  Future<void> getNotificationCount()async{
    notificationCount.value = await apiNotificationClient.getNotificationCount();
  }

  /// 알림 삭제
  Future<void> deleteNotification(int index,int notificationId) async {
    notificationList.removeAt(index);
    notificationList.refresh();
    await apiNotificationClient.deleteNotification(notificationId);
  }

  /// 알림 단일 읽음 처리
  Future<void> readNotification(int notificationId)async{
    await apiNotificationClient.readNotification(notificationId);
  }

  /// 알림 전체 읽음 처리
  Future<void> readAllNotification()async{
    notificationCount.value = 0;
    await apiNotificationClient.readAllNotification();
  }

  /// 알림 여행 기록 가져오기
  Future<void> getNotificationDetail(int tripId,int historyId)async{
    notificationHistory.value = await apiHistoryClient.getDetailHistoryList(tripId, historyId);
  }

  /// 여행 기록 댓글 가져오기
  Future<void> getNotificationComment(int tripId,int historyId) async {
    notificationComment.value = await apiHistoryClient.getDetailHistoryCommentList(tripId,historyId);
    notificationComment.refresh();
  }

  /// 여행 댓글 등록하기
  Future<void> addNotificationComment(int tripId,int historyId,String comment,bool search) async {
    notificationComment.value = await apiHistoryClient.addHistoryComment(tripId,historyId,comment);
    notificationHistory['replyCnt'] = notificationComment.length;

    notificationComment.refresh();
    notificationHistory.refresh();
  }
  /// 여행 수정 하기
  Future<void> editNotificationComment(int tripId,int historyId,int replyId,String content) async {
    notificationComment.value = await apiHistoryClient.editHistoryComment(tripId,historyId,replyId,content);
    notificationComment.refresh();
  }
  /// 여행 댓글 삭제
  Future<void> deleteNotificationComment(int tripId,int historyId,int replyId) async {
    notificationComment.value = await apiHistoryClient.deleteHistoryComment(tripId,historyId,replyId);
    notificationHistory['replyCnt'] = notificationComment.length;
    notificationHistory.refresh();
    notificationComment.refresh();
  }
  /// 좋아요 토글
  Future<void> notificationToggle(int tripId,int historyId) async {
    bool checked = await apiHistoryClient.historyListToggle(tripId,historyId);
    if(checked){
      notificationHistory['like'] = true;
      notificationHistory['likeCnt']++;
    }else{
      notificationHistory['like'] = false;
      notificationHistory['likeCnt']--;
    }
  }

}