import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';

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
      appBar: BackAppBar(text: '스크랩', onTap: (){Get.back();}),
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
                            embedBuilders: kIsWeb ? FlutterQuillEmbeds.editorWebBuilders() : FlutterQuillEmbeds.editorBuilders(),
                          ),
                        ),
                      ),
                      us.userList[0]['uuid']==ss.scrapList[0]['writerUuid'] ?Row(
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
