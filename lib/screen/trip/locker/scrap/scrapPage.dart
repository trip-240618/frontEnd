import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/button/plusFloating.dart';
import 'package:tripStory/controller/scrapState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/trip/locker/scrap/scrap_edit.dart';
import 'package:tripStory/screen/trip/locker/scrap/scrap_view.dart';
import '../../../../component/dialog/dialog.dart';
import '../../../../component/dialog/loading.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';
import 'addScrapPage.dart';

class ScrapPage extends StatefulWidget {
  const ScrapPage({super.key});

  @override
  State<ScrapPage> createState() => _ScrapPageState();
}
class _ScrapPageState extends State<ScrapPage> {
  final us = Get.put(UserState());
  final ss = Get.put(ScrapState());
  bool bookmarkChecked = false;
  bool isLoading = true;


  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await ss.getScrapList();
      isLoading = false;
      setState(() {

      });
    });
    super.initState();
  }

  String jsonToString(String jsonData){
    var myJson = jsonDecode(jsonData);
    QuillController _controller = QuillController.basic();
    _controller = QuillController(
      document: Document.fromJson(myJson),
      selection: TextSelection.collapsed(offset: 0),
    );
    String stringText = _controller.document.toPlainText();
    return stringText;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? SizedBox() : Scaffold(
      backgroundColor: gray50,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: ss.scrapList.isEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('여행에 필요한 정보를', style: f22gray400w700,)),
            Center(child: Text('스크랩 해보세요 :)', style: f22gray400w700,))
          ],
        ) :
        Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    bookmarkChecked = !bookmarkChecked;
                    setState(() {
                      isLoading = true;
                    });
                    bookmarkChecked
                        ? await ss.getScrapBookmark()
                        : await ss.getScrapList();
                    setState(() {
                      isLoading = false;
                    });
                    setState(() {
                    });
                  },
                  child: bookmarkChecked == false?
                  Container(
                    width:20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffE0E0E0),width: 1.5),
                        shape: BoxShape.circle
                    ),
                  ):
                  Container(
                    width:20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: gray900,
                        shape: BoxShape.circle
                    ),
                    child: SvgPicture.asset('assets/icon/smallCheck.svg',fit: BoxFit.none),
                  ),
                ),
                const SizedBox(width: 6,),
                Text('북마크', style: f12gray600w600,)
              ],
            ),
            const SizedBox(height: 12,),
            Obx(()=>Expanded(
              child: MasonryGridView.count(
                physics: const ClampingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: ss.scrapList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await ss.getSelectScrapList(ss.scrapList[index]['id']);
                      us.userList[0]['uuid']==ss.scrapList[0]['writerUuid'] ?
                      Get.to(()=>ScrapEdit()):
                      Get.to(()=>ScrapView());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(
                              color: gray200,
                              width: 1
                          )
                      ),
                      //height: 194*(index/2),
                      constraints: BoxConstraints(
                          maxHeight: 231,
                          minHeight: 133
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: Get.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(int.parse('${ss.scrapList[index]['color']}')),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                border: Border(
                                    bottom: BorderSide(
                                        color: gray200,
                                        width: 1
                                    )
                                )
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      await ss.clickScrapBookmark(ss.scrapList[index]['id']);
                                      ss.scrapList[index]['bookmark'] = !ss.scrapList[index]['bookmark'];
                                      ss.scrapList.refresh();
                                    },
                                    child: ss.scrapList[index]['bookmark']
                                        ? SvgPicture.asset('assets/icon/checkBookmark.svg',)
                                        : SvgPicture.asset('assets/icon/bookmark.svg',),),
                                  const SizedBox(width: 6,),
                                  Text(DateFormat('yyyy.MM.dd').format(DateTime.parse('${ss.scrapList[index]['createDate']}')), style: f11Gray900w400,),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ss.scrapList[index]['hasImage']
                                    ?Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: SvgPicture.asset('assets/icon/normalImage.svg',colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)),
                                )
                                    :const SizedBox(),
                                Text('${ss.scrapList[index]['title']}', overflow: TextOverflow.ellipsis,maxLines: 2, style: f14gray800w700,),
                                const SizedBox(height: 4,),
                                Text(jsonToString(ss.scrapList[index]['preview']), overflow: TextOverflow.ellipsis,maxLines: 4,  style: f12Gray800w500)
                              ],
                            ),
                          ),
                          Container(
                            height: 34,
                            child: Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Text('${ss.scrapList[index]['nickname']}', style: f11Gray600w400,),
                                  Spacer(),
                                  us.userList[0]['uuid']==ss.scrapList[0]['writerUuid'] ?
                                  GestureDetector(
                                      onTap: () async {
                                        showConfirmCancelTapDialog(context, '스크랩을 삭제하시겠습니까?', '확인','스크랩 삭제 후 복구는 어렵습니다',() async {
                                          await ss.deleteScrap(int.parse('${ss.scrapList[index]['id']}'));
                                          await ss.getScrapList();
                                          Get.back();
                                        } );
                                      },
                                      child: SvgPicture.asset('assets/icon/trashCan.svg'))
                                      : const SizedBox(),
                                ],

                              ),

                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
              )
            ),)
          ],
        ),
      ),
      floatingActionButton: PlusFloatingButton(
        backgroundColor: gray900,
        onPressed: ()  {
          Get.to(()=>AddScrapPage());
        },)
    );
  }
}
