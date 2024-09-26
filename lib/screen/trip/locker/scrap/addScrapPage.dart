import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';

class AddScrapPage extends StatefulWidget {
  const AddScrapPage({super.key});

  @override
  State<AddScrapPage> createState() => _AddScrapPageState();
}

class _AddScrapPageState extends State<AddScrapPage> {
  TextEditingController titleCon = TextEditingController();
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int selectedColor = 0;


  @override
  void initState() {
    //jsonD();
    super.initState();
  }

  void jsonD() {
    var myJson = jsonDecode(r'[{"insert":"Ddfsdfd\nㅇㅏㄴㄴㅕㅇㅎㅏㅅㅔㅇㅛ"},{"insert":{"image":"https://trip-story.s3.ap-northeast-2.amazonaws.com/test/6bb5a043-fd6f-4f00-8803-35e7823c3287"}},{"insert":{"image":"https://trip-story.s3.ap-northeast-2.amazonaws.com/test/6bb5a043-fd6f-4f00-8803-35e7823c3287"}},{"insert":"\n"}]');
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


    final imageUrl = 'https://trip-story.s3.ap-northeast-2.amazonaws.com/test/6bb5a043-fd6f-4f00-8803-35e7823c3287';


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
        body: Padding(
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
                            embedBuilders: kIsWeb ? FlutterQuillEmbeds.editorWebBuilders() : FlutterQuillEmbeds.editorBuilders(),
                            autoFocus: true
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                            },
                            child: SvgPicture.asset('assets/icon/brush.svg',),
                          ),
                          const SizedBox(width: 8,),
                          GestureDetector(
                            onTap: (){
                              _onPressedHandler(context);
                            },
                            child: SvgPicture.asset('assets/bottomNavi/tripHistory.svg',),
                          ),
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

    );
  }

}
