import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/main/typeChoose.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/main/tripAdd/tripCalendar.dart';
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
  TextEditingController tripName = TextEditingController(); /// 여행방 입력

  @override
  void dispose() {
    tripName.dispose();
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
        body: Column(
          children: [
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 7),
                child: Column(
                  children: [
                    Obx(()=>GestureDetector(
                      onTap: (){
                        ms.getSingleImage(ImageSource.gallery,context);
                      },
                      child: ms.pickedImage.value!=null
                          ? Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.file(
                            File(ms.pickedImage.value!.path),
                            width: 90,
                            height: 90,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                          :Center(
                        child: Container(
                          width: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0xFFEEEEEE), // 색상 코드 #EEEEEE를 Flutter의 Color로 변환
                                        width: 1.0, // border의 두께 (1px)
                                      ),
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icon/image.svg'),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SvgPicture.asset('assets/icon/plus.svg'))

                            ],
                          ),
                        ),),
                    )),
                    const SizedBox(height: 16),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: gray200)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: tripName,
                                style: f16gray800w600,
                                onChanged: (con){
                                  setState(() {});
                                },
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(15),
                                ],
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: '여행방 제목을 입력해주세요',
                                  hintStyle: f14Gray500w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('${tripName.text.length}/15 ')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('아이콘 컬러',style: f12gray600w600,),
                      Container(
                        width: Get.width,
                        height: 44,
                        color: Colors.green,
                        child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context, index) {
                              return Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        color: pastelBlue
                                    ),
                                  ),
                                  const SizedBox(width: 12)
                                ],
                              );
                            },
                          ),
                      ),
                      const SizedBox(height: 20,),
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
                          Get.to(()=>TripCalendar());
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
                    ],
                  ),
                ),
              ),
            ),
          ],
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
