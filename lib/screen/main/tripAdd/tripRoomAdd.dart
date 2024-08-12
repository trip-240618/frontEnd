import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/component/dialog.dart';
import 'package:tripStory/component/main/typeChoose.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/util/color.dart';
import '../../../component/bottomContainer.dart';
import '../../../util/font.dart';

class TripRoomAddScreen extends StatefulWidget {
  const TripRoomAddScreen({super.key});

  @override
  State<TripRoomAddScreen> createState() => _TripRoomAddScreenState();
}

class _TripRoomAddScreenState extends State<TripRoomAddScreen>{
  final ms = Get.put(MainState());
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(text: '여행방 만들기', onTap: () {
          ms.roomReset();
          Get.back();
        }),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(()=>GestureDetector(
                    onTap: (){
                      ms.getSingleImage(ImageSource.gallery);
                    },
                    child: ms.pickedImage.value!=null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.file(
                          File(ms.pickedImage.value!.path),
                          width: Get.width,
                          height: 260,
                          fit: BoxFit.fill,
                        ),
                       )
                        :Container(
                      width: Get.width,
                      height: 260,
                      decoration: BoxDecoration(
                          color: gray200,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icon/image.svg'),
                          const SizedBox(height: 8,),
                          Text('여행 프로필 사진을 등록해보세요',style: f14Gray400w500,)
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: ms.tripName,
                    textAlignVertical: TextAlignVertical.center,
                    style: f16gray800w600,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
                      ),
                      hintText: '여행지를 검색해주세요',
                      hintStyle: f14Gray500w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('여행방 타입 선택'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: TypeChoose(text: 'J형',onTap: (){
                          ms.tripType.value = 'J형';
                          setState(() {});
                        },value: ms.tripType.value),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TypeChoose(text: 'P형',onTap: (){
                          ms.tripType.value = 'P형';
                          setState(() {});
                        },value: ms.tripType.value,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('여행지'),
                  const SizedBox(height: 4),
                  Obx(() => GestureDetector(
                    onTap: ()async{
                      await ms.bottomModalReset();
                      bottomModel(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: gray200)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icon/search.svg',fit: BoxFit.none),
                            const SizedBox(width: 4),
                            ms.tripDestination.value ==''?Text('여행지를 검색해주세요',style: f14Gray500w400):Text('${ms.tripDestination.value}')
                          ],
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 20),
                  Text('여행일정'),
                  const SizedBox(height: 4),
                  Obx(() => GestureDetector(
                    onTap: ()async{
                      ms.tripDate.value = '11';
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: gray200)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icon/search.svg',fit: BoxFit.none),
                            const SizedBox(width: 4),
                            ms.tripDate.value ==''?Text('여행 시작일과 종료일을 입력해주세요',style: f14Gray500w400):Text('${ms.tripDestination.value}')
                          ],
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 20),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],),
            ),
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 44),
        child: BottomContainer(onTap: ()async{
          bool isCreate = await ms.createRoom();
          if(isCreate){
            CodeDialog(context);
          }
          print('text ${isCreate}');
          // Get.to(()=>ProfileScreen());
        },title: '저장'),
      ),
      ),
    );
  }
}
