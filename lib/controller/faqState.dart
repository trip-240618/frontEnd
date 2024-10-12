import 'package:get/get.dart';
import '../app/api/faqApi.dart';
import '../app/config/dio_client.dart';

class FaqState extends GetxController{
  final apiFaqClient = ApiFaqClient(DioClient());
  final RxList faqList = [].obs; /// faq 리스트
  final RxList searchFaqList = [].obs; /// 검색한 faq 리스트
  final RxMap faqDetailList = {}.obs; /// 공지사항 디테일 리스트


  /// faq 리스트
  Future<void> getFaq(String field)async{
    faqList.value = await apiFaqClient.getFaqList(field);
    faqList.refresh();
  }

  /// faq 검색
  Future<void> searchFaq(String text)async{
    searchFaqList.value = await apiFaqClient.searchFaqList(text);
    searchFaqList.refresh();
  }

  /// faq 상세
  Future<void> getFaqDetail(int faqId)async{
    faqDetailList.value = await apiFaqClient.getFaqDetailList(faqId);
    faqDetailList.refresh();
  }

}