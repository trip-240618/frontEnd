import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';


class ScrapEdit extends StatefulWidget {
  const ScrapEdit({super.key});

  @override
  State<ScrapEdit> createState() => _ScrapEditState();
}

class _ScrapEditState extends State<ScrapEdit> {
  final us = Get.put(UserState());
  final ss = Get.put(ScrapState());
  TextEditingController titleCon = TextEditingController();
  QuillController _controller = QuillController.basic();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int selectedColor = 0;
  XFile? pickedImage;
  FToast fToast  = FToast();


  @override
  void initState() {
    selectedColor = colorList.indexOf(Color(int.parse(ss.selectScrapList[0]['color'])));
    fToast = FToast();
    fToast.init(context);
    Future.delayed(Duration.zero,()async{
     await ss.scrapImgUrlReset();
    });
    jsonD();
    _focusNode.addListener(() {
      setState(() {});
      if (_focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent * 2,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        });
      }
    });
    _controller.addListener((){
      setState(() {});
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
  void das(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent*2, // 스크롤 가능한 최대 위치로 이동
      duration: Duration.zero,   // 애니메이션 지속 시간
      curve: Curves.easeInOut,                  // 애니메이션 커브
    );
    setState(() {

    });
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

  Future<void> editScrap() async{
    var json = jsonEncode(_controller.document.toDelta().toJson());
    List<dynamic> decodedJson = jsonDecode(json);
    /// 맨뒤 링크만 있을 경우 포멧팅 에러가 있어서 \n 추가
    if (decodedJson.isNotEmpty && decodedJson.last['insert'] == "\n") {
      decodedJson.last['insert'] = "\n\n";
    }
    /// 수정된 리스트를 다시 JSON 문자열로 인코딩
    var modifiedJson = jsonEncode(decodedJson);
    bool hasImage = isImageIncluded();
    /// 기존 이미지가 있는데 이미지를 지웠을경우에 별도 삭제처리 해줘야함
    /// has 이미지가 있을때 포토리스트 값은 여기서 addurl할지, 기존 select값 보낼때 처리
    await ss.modifyScrap(
        ss.selectScrapList[0]['id'],
        titleCon.text,
        modifiedJson,
        hasImage,
        '0x${colorList[selectedColor].value.toRadixString(16).toUpperCase()}',
        hasImage?ss.addImgUrl.isEmpty?ss.selectScrapList[0]['imageDtos']:[{'id':0,'imageUrl':ss.addImgUrl.split('?')[0]}]:[]);
  }
  bool isImageIncluded(){
    List<dynamic> jsonData = _controller.document.toDelta().toJson();
    bool hasImage = jsonData.any((element) => element["insert"] is Map && element["insert"].containsKey("image"));
    return hasImage;
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
        appBar: TrailingBackAppBar(text: '스크랩 수정',
          backTap: () async {
          if(ss.addImgUrl.isNotEmpty) await ss.removeImage(ss.addImgUrl.value);
          Get.back();},
          svgPicture: SvgPicture.asset( 'assets/icon/save.svg',fit: BoxFit.none,),
            trailingTap: () async {
              await editScrap().then((_) async {
                 await ss.getScrapList();
                 Get.back();
               });
            }),
        body: SingleChildScrollView(
          controller: _scrollController,
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
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: QuillEditor.basic(
                              focusNode: _focusNode,
                              controller: _controller,
                              // scrollController: _scrollController,
                              configurations: QuillEditorConfigurations(
                                scrollable: true,
                                showCursor: true,
                                customStyles: DefaultStyles(),
                                magnifierConfiguration: TextMagnifierConfiguration(
                                    shouldDisplayHandlesInMagnifier: true
                                ),
                                embedBuilders: kIsWeb ? FlutterQuillEmbeds.editorWebBuilders() : FlutterQuillEmbeds.editorBuilders(
                                    imageEmbedConfigurations: QuillEditorImageEmbedConfigurations(
                                        onImageClicked: (node){
                                          _controller.updateSelection(
                                            TextSelection(baseOffset: node.length, extentOffset: node.length),
                                            ChangeSource.local,
                                          );
                                        }
                                    )
                                ),
                              ),
          
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
                                  /// content에는 삭제했지만 추가한 이미지url가 있는 경우 기존 url 삭제
                                  if(ss.addImgUrl.isNotEmpty){
                                    await ss.removeImage(ss.addImgUrl.value);
                                    await ss.scrapImgUrlReset();
                                  }
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
                    SizedBox(height:
                      // _focusNode.hasFocus
                      //   ? MediaQuery.of(context).viewInsets.bottom + 100
                      //   : 0
                      _focusNode.hasFocus
                        ? MediaQuery.of(context).viewInsets.bottom + 50
                        : 0
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }

}
