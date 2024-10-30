import 'package:get/get.dart';
import 'package:tripStory/app/api/notiApi.dart';
import 'package:tripStory/app/api/notificationApi.dart';
import '../app/api/historyApi.dart';
import '../app/api/tripApi.dart';
import '../app/config/dio_client.dart';

class NotiState extends GetxController{
  final selectTabIndex = 0.obs;
  final apiNotificationClient = ApiNotificationClient(DioClient());
  final apiHistoryClient = ApiHistoryClient(DioClient());
  final notificationList = [].obs;
  final notificationHistory = {}.obs; /// 알림에서 들어가는 여행 기록 리스트
  final notificationComment = [].obs; /// 알림에서 들어가는 여행 댓글


  /// 알림 기록 가져오기
  Future<void> getNotificationList(String title)async{
    notificationList.value = await apiNotificationClient.getNotificationList(title);
    notificationList.refresh();
  }

  /// 알림 단일 읽음 처리
  Future<void> readNotification(int notificationId)async{
    await apiNotificationClient.readNotification(notificationId);
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