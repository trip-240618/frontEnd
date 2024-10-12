import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/scrapState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';

class AddScrapPage extends StatefulWidget {
  const AddScrapPage({super.key});

  @override
  State<AddScrapPage> createState() => _AddScrapPageState();
}

class _AddScrapPageState extends State<AddScrapPage> {
  final ss = Get.put(ScrapState());
  TextEditingController titleCon = TextEditingController();
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int selectedColor = 0;
  XFile? pickedImage;
  FToast fToast  = FToast();


  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _controller.addListener((){
      setState(() {
      });
    });
    super.initState();
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


    final imageUrl = ss.addImgUrl.split('?')[0];


    if (imageUrl.isNotEmpty) {
      await options.imageButtonConfigurations
          .onImageInsertCallback(imageUrl, _controller);
      await options.imageButtonConfigurations.onImageInsertedCallback
          ?.call(imageUrl);
    }
  }

  bool isImageIncluded(){
    List<dynamic> jsonData = _controller.document.toDelta().toJson();
    bool hasImage = jsonData.any((element) => element["insert"] is Map && element["insert"].containsKey("image"));
    return hasImage;
  }

  Future<void> scrapSave() async {
    var json = jsonEncode(_controller.document.toDelta().toJson());
    print('json저장');
    print(titleCon.text);
    print('image?${[ss.addImgUrl.split('?')[0]]}');
    bool hasImage = isImageIncluded();
    await ss.createScrap(titleCon.text, json, hasImage, '${colorList[selectedColor]}', hasImage?[ss.addImgUrl.split('?')[0]]:[]);
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
        appBar: TrailingBackAppBar(
          text: '스크랩',
          backTap: () async {
            if(ss.addImgUrl.isNotEmpty) await ss.removeImage(ss.addImgUrl.value);
            Get.back();},
          svgPicture: SvgPicture.asset( 'assets/icon/save.svg',fit: BoxFit.none,),
          trailingTap: (){
            scrapSave().then((_) async {
              await ss.getScrapList();
              Get.back();
            });
            },),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:15, left: 20, right: 20, bottom: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleCon,
                  style: f16gray800w700,
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
                              onTap: () async {
                                if(isImageIncluded()){
                                  fToast.showToast(
                                    child: Container(
                                      width: Get.width,
                                      height: 58,
                                      decoration: BoxDecoration(
                                        color: Color(0xff212121).withOpacity(0.7),  // 반투명한 배경
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x1A000000),
                                            offset: Offset(0, 4),
                                            blurRadius: 9,
                                          ),
                                          BoxShadow(
                                            color: Color(0x17000000),
                                            offset: Offset(0, 16),
                                            blurRadius: 16,
                                          ),
                                          BoxShadow(
                                            color: Color(0x0D000000),
                                            offset: Offset(0, 36),
                                            blurRadius: 21,
                                          ),
                                          BoxShadow(
                                            color: Color(0x03000000),
                                            offset: Offset(0, 63),
                                            blurRadius: 25,
                                          ),
                                          BoxShadow(
                                            color: Color(0x00000000),
                                            offset: Offset(0, 99),
                                            blurRadius: 28,
                                          ),
                                        ],
                                      ),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('기존 이미지 삭제 후 업로드 가능합니다.',style: f12whitew500,),
                                        ],
                                      )),
                                    ),
                                    gravity: ToastGravity.TOP,
                                    toastDuration: Duration(seconds: 2),
                                  );

                                }else{
                                  pickedImage = await ss.getSingleImage(ImageSource.gallery,context,pickedImage);
                                  await ss.scrapFileUpload(pickedImage!);

                                  _onPressedHandler(context);

                                }
                              },
                              child: SvgPicture.asset('assets/icon/normalImage.svg',colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)),
                            ),
                            Spacer(),
                            Text('${_controller.document.length}', style: f11Gray800w600,),
                            Text('/1000', style: f11Gray400w600,),
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
