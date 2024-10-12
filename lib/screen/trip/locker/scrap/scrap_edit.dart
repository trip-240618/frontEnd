import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/scrapState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';


class ScrapEdit extends StatefulWidget {
  const ScrapEdit({super.key});

  @override
  State<ScrapEdit> createState() => _ScrapEditState();
}

class _ScrapEditState extends State<ScrapEdit> {
  final ss = Get.put(ScrapState());
  TextEditingController titleCon = TextEditingController();
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int selectedColor = 0;


  @override
  void initState() {
    print('이거 선택되나?${ss.selectScrapList[0]['content']}');
    jsonD();
    // String jsonString = '[{"insert":"ㄴㅇㅇㅇ유옹ㅍㅇㅍㅇ"},{"insert":{"image":"https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/cafeImage.jpeg?alt=media"}},{"insert":"\\n"}]';
    //
    // // JSON 문자열을 파싱하여 List로 변환
    // List<dynamic> jsonData = jsonDecode(jsonString);
    //
    // // 이미지가 포함되어 있는지 확인
    // bool containsImage = jsonData.any((element) => element["insert"] is Map && element["insert"].containsKey("image"));
    //
    // print('????${containsImage}'); // 이미지가 포함된 경우 true, 포함되지 않은 경우 false

    _controller.addListener((){
      setState(() {
      });
    });
    super.initState();
  }

  void jsonD() {
    var myJson = jsonDecode(ss.selectScrapList[0]['content']);
    titleCon.text = ss.selectScrapList[0]['title'];
    _controller = QuillController(
      document: Document.fromJson(myJson),
      selection: TextSelection.collapsed(offset: 0),
    );
  }



  OnImageInsertCallback defaultOnImageInsertCallback() {
    return (imageUrl, controller) async {
      controller
        ..skipRequestKeyboard = true
        ..insertImageBlock(imageSource: imageUrl);
    };
  }

  Future<void> _onPressedHandler(BuildContext context) async {
    var options = const QuillToolbarImageButtonOptions();
    final imagePickerService =
        QuillSharedExtensionsConfigurations.get(context: context)
            .imagePickerService;

    final onRequestPickImage =
        options.imageButtonConfigurations.onRequestPickImage;
    if (onRequestPickImage != null) {
      final imageUrl = await onRequestPickImage(
        context,
        imagePickerService,
      );
      if (imageUrl != null) {
        await options.imageButtonConfigurations
            .onImageInsertCallback(imageUrl, _controller);
        await options.imageButtonConfigurations.onImageInsertedCallback
            ?.call(imageUrl);
      }
      return;
    }


    final imageUrl = 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/cafeImage.jpeg?alt=media';


    if (imageUrl.isNotEmpty) {
      await options.imageButtonConfigurations
          .onImageInsertCallback(imageUrl, _controller);
      await options.imageButtonConfigurations.onImageInsertedCallback
          ?.call(imageUrl);
    }
  }


  void scrapSave(){
    var json = jsonEncode(_controller.document.toDelta().toJson());
    print('json저장');
    print(titleCon.text);
    print('${colorList[selectedColor]}');
    ss.createScrap(titleCon.text, json, false, '${colorList[selectedColor]}', []);

    print(json);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {
        });
      },
      child: Scaffold(
        backgroundColor: gray50,
        resizeToAvoidBottomInset: false,
        appBar: TrailingBackAppBar(text: '스크랩', backTap: (){Get.back();}, svgPicture: SvgPicture.asset( 'assets/icon/save.svg',fit: BoxFit.none,),trailingTap: (){scrapSave();},),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:15, left: 20, right: 20, bottom: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: '제목을 입력해주세요',
                    hintStyle: f16gray300w700,
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
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
                            focusNode: _focusNode,
                            controller: _controller,
                            configurations: QuillEditorConfigurations(
                              showCursor: true,
                              customStyles: DefaultStyles(),
                              magnifierConfiguration: TextMagnifierConfiguration(
                                  shouldDisplayHandlesInMagnifier: true
                              ),
                              embedBuilders: kIsWeb ? FlutterQuillEmbeds.editorWebBuilders() : FlutterQuillEmbeds.editorBuilders(),
                            ),

                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                print('11111');
                                _onPressedHandler(context);
                              },
                              child: SvgPicture.asset('assets/icon/normalImage.svg',colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)),
                            ),
                            Text('${_controller.document.length}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('태그 컬러', style: f12gray600w600,),
                    const SizedBox(height: 2,),
                    Container(
                      width: Get.width,
                      height: 44,
                      child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    selectedColor = index;
                                    setState(() {});
                                  },
                                  child: selectedColor==index
                                      ? Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: gray900,width: 2),
                                        color: colorList[index]
                                    ),
                                    child: SvgPicture.asset('assets/icon/checkIcon.svg',fit: BoxFit.none,),
                                  )
                                      :  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorList[index],
                                        border: colorList[index] == whiteColor?Border.all(color: gray200):null
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }

}
