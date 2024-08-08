import 'package:get/get.dart';

class MainState extends GetxController{
  final selectIdx = 0.obs; /// (탭바 클릭)



  /// 초기화 함수
  @override
  void onClose() {
    selectIdx.value = 0;
    super.onClose();
  }
}