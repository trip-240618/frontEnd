import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/reportState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/locker/scrap/scrap_edit.dart';

import '../../../../component/dialog/dialog.dart';
import '../../../../controller/scrapState.dart';
import '../../../../controller/userState.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';

class ScrapView extends StatefulWidget {
  const ScrapView({super.key});

  @override
  State<ScrapView> createState() => _ScrapViewState();
}

class _ScrapViewState extends State<ScrapView> {
  final ts = Get.put(TripState());
  final rs = Get.put(ReportState());
  final us = Get.put(UserState());
  final ss = Get.put(ScrapState());
  QuillController _controller = QuillController.basic();
  void jsonD() {
    var myJson = jsonDecode(ss.selectScrapList[0]['content']);
    _controller = QuillController(
      readOnly: true,
      document: Document.fromJson(myJson),
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void initState() {
    jsonD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      resizeToAvoidBottomInset: false,
      appBar: popupBackAppBar(text: '스크랩',
        popupMenuButton: PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            offset: const Offset(-10, 20),
            shadowColor: Colors.black.withOpacity(0.4),
            child: SvgPicture.asset(
              'assets/icon/dot.svg',
              width: 24,
              color: gray900,
            ),
            color: gray50,
            padding: EdgeInsets.zero,
            menuPadding: EdgeInsets.zero,
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              us.userList[0].uuid==ss.selectScrapList[0]['writerUuid']?
              PopupMenuItem<int>(
                padding: EdgeInsets.zero,
                value: 1,
                onTap: (){
                  Get.back();
                  Get.to(()=>ScrapEdit());
                },
                child: Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                      const SizedBox(width: 10,),
                      Text(
                        '수정하기',
                        style: f14Gray800w500,
                      ),
                    ],
                  ),
                ),
              ):
              PopupMenuItem<int>(
                padding: EdgeInsets.zero,
                value: 1,
                onTap: (){
                  showConfirmCancelTapDialog(context, '해당 스크랩을 신고하시겠습니까?', '확인',null,() async {
                    Map data =
                    {
                      "type" : 'scrap',
                      "tripId" : '${ts.selectTripList[0]['id']}',
                      "typeId":'${ss.selectScrapList[0]['id']}'
                    };
                    print('data??${data}');
                    await rs.addReport('scrap', null,ss.selectScrapList[0]['id']);
                    Get.back();
                    showOnlyConfirmTapDialog(context, '신고가 접수가 완료되었습니다.',(){
                      Get.back();
                      Get.back();
                    });
                  } );

                },
                child: Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: SvgPicture.asset('assets/icon/siren.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                      const SizedBox(width: 10,),
                      Text(
                        '신고하기',
                        style: f14Gray800w500,
                      ),
                    ],
                  ),
                ),
              ),
            ]),

          ),

      //BackAppBar(text: '스크랩', onTap: (){Get.back();}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:15, left: 20, right: 20, bottom: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${ss.selectScrapList[0]['title']}',style: f16gray800w700),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 1,
                      color: gray200
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        height: Get.height*0.6,
                        child: QuillEditor.basic(
                          controller: _controller,
                          configurations: QuillEditorConfigurations(
                            showCursor: false,
                            customStyles: DefaultStyles(),
                            checkBoxReadOnly: true,
                            magnifierConfiguration: TextMagnifierConfiguration(
                                shouldDisplayHandlesInMagnifier: true
                            ),
                            embedBuilders: kIsWeb ? FlutterQuillEmbeds.editorWebBuilders() : FlutterQuillEmbeds.editorBuilders(
                                imageEmbedConfigurations: QuillEditorImageEmbedConfigurations(
                                    onImageClicked: (node){
                                    }
                                )
                            ),
                          ),
                        ),
                      ),
                      us.userList[0].uuid==ss.scrapList[0]['writerUuid'] ?Row(
                        children: [
                          Spacer(),
                          Text('${_controller.document.length}', style: f11Gray800w600,),
                          Text('/1000', style: f11Gray400w600,),
                        ],
                      ):const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ),
      ),

    );
  }
}
