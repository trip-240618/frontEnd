import 'package:get/get.dart';
import '../app/api/notiApi.dart';
import '../app/config/dio_client.dart';


class Notistate extends GetxController{
  final apiNotiClient = ApiNotiClient(DioClient());
  final RxList notiList = [].obs; /// 공지사항 리스트
  final RxMap notiDetailList = {}.obs; /// 공지사항 디테일 리스트


  /// 공지사항 리스트
  Future<void> getNoti(String field)async{
    notiList.value = await apiNotiClient.getNotiList(field);
    notiList.refresh();
  }

  /// 공지사항 디테일 리스트
  Future<void> getDetailNoti(int noticeId,String type)async{
    notiDetailList.value = await apiNotiClient.getDetailNotiList(noticeId,type);
    notiDetailList.refresh();
  }
}