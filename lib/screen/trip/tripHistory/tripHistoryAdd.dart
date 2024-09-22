import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import '../../../component/appbar.dart';
import '../../../component/bottomContainer.dart';
import '../../../controller/historyState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class TripHistoryAddPage extends StatefulWidget {
  const TripHistoryAddPage({super.key});

  @override
  State<TripHistoryAddPage> createState() => _TripHistoryAddPageState();
}

class _TripHistoryAddPageState extends State<TripHistoryAddPage> {
  final hs = Get.put(HistoryState());
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '', onTap: (){Get.back();}),
        body: Stack(
          children: [
            AssetEntityImage(
              gaplessPlayback: true,
              filterQuality: FilterQuality.high,
              isOriginal: false,
              thumbnailSize: ThumbnailSize.square(700),
              thumbnailFormat: ThumbnailFormat.png,
              hs.selectAlbumList[0],
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            )
          ],
        ),
        bottomSheet: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1AD4D4D4),
                offset: Offset(0, -3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Color(0x17D4D4D4),
                offset: Offset(0, -10),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Color(0x0DD4D4D4),
                offset: Offset(0, -23),
                blurRadius: 14,
              ),
              BoxShadow(
                color: Color(0x03D4D4D4),
                offset: Offset(0, -40),
                blurRadius: 16,
              ),
              BoxShadow(
                color: Color(0x00D4D4D4),
                offset: Offset(0, -63),
                blurRadius: 18,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: gray200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (con){
                          setState(() {});
                        },
                        // cursorColor: mainColor,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: '여행 일정을 입력해주세요',
                          hintStyle: f15gray400w500,
                        ),
                        controller: _controller,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(18),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text('${_controller.text.length}', style: _controller.text.length>0?f11Gray800w600:f11Gray400w600,),
                    Text('/18 ', style: f11Gray400w600,),
                    const SizedBox(width: 8,),
                    SvgPicture.asset('assets/icon/roundArrowRight.svg')
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar:Obx(()=>Container(
            width: Get.width,
            decoration: BoxDecoration(
            ),
            height: hs.selectAlbumList.length==0?120:250,
            child: hs.selectAlbumList.length==0
                ?Center(child: Text('최대 0장을 여행 기록으로 업로드 가능해요.',style: f14Gray500w400,))
                : Padding(
              padding: const EdgeInsets.only(left: 0,right: 0,top: 17,bottom: 34),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      width: Get.width,
                      height: 100,
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
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: AssetEntityImage(
                                      gaplessPlayback: true,
                                      filterQuality: FilterQuality.high,
                                      isOriginal: false,
                                      width: 80,
                                      height: 80,
                                      thumbnailSize: ThumbnailSize.square(500),
                                      thumbnailFormat: ThumbnailFormat.png,
                                      hs.selectAlbumList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: GestureDetector(
                                      onTap: () {
                                        hs.removeFromSelectedAlbum(hs.selectAlbumList[index]);
                                      },
                                      child: SvgPicture.asset('assets/icon/xicon.svg'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('길게 눌러 순서를 변경할 수 있어요.', style: f14Gray500w400),
                  const SizedBox(height: 8),
                  Spacer(),
                  BlackCountContainer(onTap: (){
                    Get.to(()=>TripHistoryAddPage());
                  },title: '업로드',count: hs.selectAlbumList.length,),
                ],
              ),
            )
        ))
    );
  }
}
