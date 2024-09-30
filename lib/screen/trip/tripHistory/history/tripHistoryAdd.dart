import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:tripStory/screen/trip/tripHistory/history/tripHistoryDetail.dart';
import '../../../../component/appbar.dart';
import '../../../../component/bottomContainer.dart';
import '../../../../controller/historyState.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';
import '../tagAddPage.dart';

class TripHistoryAddPage extends StatefulWidget {
  const TripHistoryAddPage({super.key});

  @override
  State<TripHistoryAddPage> createState() => _TripHistoryAddPageState();
}

class _TripHistoryAddPageState extends State<TripHistoryAddPage> {
  final hs = Get.put(HistoryState());
  List<TextEditingController> albumTextList = [];
  int selectIdx = 0;
  @override
  void initState() {
    for(int i=0;i<hs.selectAlbumList.length;i++){
      albumTextList.add(TextEditingController());
    }
    super.initState();
  }
  @override
  void dispose() {
    for (var controller in albumTextList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading:  Padding(
        //   padding: const EdgeInsets.only(left: 7),
        //   child: GestureDetector(
        //     onTap: (){},
        //     child: Container(
        //       color: Colors.transparent,
        //       child: SvgPicture.asset(
        //         'assets/icon/leftArrow.svg',
        //         fit: BoxFit.none,
        //       ),
        //     ),
        //   ),
        // ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/icon/leftArrow.svg',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              '사진 등록',
              style: f16gray900w700,
            ),
            Spacer(),
            Container(
              width: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('49',style: f12gray900w500,),
                  Text('/50',style: f12gray400w500,)
                ],
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
        body: Column(
          children: [
            Stack(
              children: [
                AssetEntityImage(
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.high,
                  thumbnailSize: ThumbnailSize.square(700),
                  thumbnailFormat: ThumbnailFormat.png,
                  hs.selectAlbumList[selectIdx],
                  width: Get.width,
                  height: 360,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xff212121).withOpacity(0.5),
                        ],
                        stops: [0.54, 1],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>TagAddPage());
                    },
                    child: Container(
                      width: 73,
                      height: 24,
                      decoration: BoxDecoration(
                        color: gray900,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(child: Text('# 태그 추가',style: f12Whitew700,)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12,),
            Obx(()=>Expanded(
              child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 44,left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          height: 70,
                          child: ReorderableListView.builder(
                            itemCount: hs.selectAlbumList.length,
                            scrollDirection: Axis.horizontal,
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final item = hs.selectAlbumList.removeAt(oldIndex);
                              hs.selectAlbumList.insert(newIndex, item);
                            },
                            itemBuilder: (context, index) {
                              return Row(
                                key: ValueKey(hs.selectAlbumList[index]), // ReorderableListView requires a unique key
                                children: [
                                  Container(
                                    width:72,
                                    height: 70,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom:0,
                                          child: GestureDetector(
                                            onTap: (){
                                              selectIdx = index;
                                              setState(() {});
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: AssetEntityImage(
                                                gaplessPlayback: true,
                                                filterQuality: FilterQuality.high,
                                                isOriginal: false,
                                                width: 64,
                                                height: 64,
                                                thumbnailSize: ThumbnailSize.square(500),
                                                thumbnailFormat: ThumbnailFormat.png,
                                                hs.selectAlbumList[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              hs.removeFromSelectedAlbum(hs.selectAlbumList[index]);
                                              albumTextList.removeAt(index);
                                              if(selectIdx!=0){
                                                selectIdx--;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: gray900,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8), // 왼쪽과 오른쪽에 8px 패딩 적용
                                                child: SvgPicture.asset(
                                                  'assets/icon/x.svg',
                                                  fit: BoxFit.contain,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('간단 메모', style: f12gray600w600),
                      ],
                    ),
                  )
              ),
            ))
          ],
        ),
        // bottomSheet: Container(
        //   width: Get.width,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Color(0x1AD4D4D4),
        //         offset: Offset(0, -3),
        //         blurRadius: 6,
        //       ),
        //       BoxShadow(
        //         color: Color(0x17D4D4D4),
        //         offset: Offset(0, -10),
        //         blurRadius: 10,
        //       ),
        //       BoxShadow(
        //         color: Color(0x0DD4D4D4),
        //         offset: Offset(0, -23),
        //         blurRadius: 14,
        //       ),
        //       BoxShadow(
        //         color: Color(0x03D4D4D4),
        //         offset: Offset(0, -40),
        //         blurRadius: 16,
        //       ),
        //       BoxShadow(
        //         color: Color(0x00D4D4D4),
        //         offset: Offset(0, -63),
        //         blurRadius: 18,
        //       ),
        //     ],
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        //     child: Container(
        //       width: Get.width,
        //       decoration: BoxDecoration(
        //         color: gray50,
        //         borderRadius: BorderRadius.circular(4),
        //         border: Border.all(color: gray200),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               child: TextFormField(
        //                 onChanged: (con){
        //                   setState(() {});
        //                 },
        //                 // cursorColor: mainColor,
        //                 decoration: InputDecoration(
        //                   isDense: true,
        //                   contentPadding: EdgeInsets.zero,
        //                   enabledBorder: OutlineInputBorder(
        //                     borderSide: BorderSide.none,
        //                   ),
        //                   focusedBorder: OutlineInputBorder(
        //                     borderSide: BorderSide.none,
        //                   ),
        //                   hintText: '여행 일정을 입력해주세요',
        //                   hintStyle: f15gray400w500,
        //                 ),
        //                 controller: _controller,
        //                 inputFormatters: <TextInputFormatter>[
        //                   LengthLimitingTextInputFormatter(18),
        //                 ],
        //               ),
        //             ),
        //             const SizedBox(width: 10,),
        //             Text('${_controller.text.length}', style: _controller.text.length>0?f11Gray800w600:f11Gray400w600,),
        //             Text('/18 ', style: f11Gray400w600,),
        //             const SizedBox(width: 8,),
        //             SvgPicture.asset('assets/icon/roundArrowRight.svg')
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      bottomSheet: Container(
        width: Get.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 10),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: gray200)
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: albumTextList[selectIdx],
                      autofocus: false,
                      style: f16gray800w600,
                      onChanged: (v){
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
                  Text('${albumTextList[selectIdx].text.length}/15',style: f11Gray400w600,)
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:Padding(
         padding: const EdgeInsets.only(bottom: 44,left: 20,right: 20,top: 46),
         child: BlackCountContainer(onTap: (){
           Get.to(()=>TripHistoryDetailPage());
         },title: '업로드',count: 0,),
       ),
    );
  }
}
