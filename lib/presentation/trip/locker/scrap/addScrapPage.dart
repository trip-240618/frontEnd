import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/color_select_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/divider/common_divider.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/trip/controllers/scrap_create_controller.dart';

class AddScrapPage extends StatefulWidget {
  const AddScrapPage({super.key});

  @override
  State<AddScrapPage> createState() => _AddScrapPageState();
}

class _AddScrapPageState extends State<AddScrapPage> {
  final _scrapCreateController = Get.find<ScrapCreateController>();
  TextEditingController titleCon = TextEditingController();
  final QuillController _controller = QuillController.basic();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _titleFocusNode = FocusNode();
  final _quillFocusNode = FocusNode();
  bool showColorPicker = false;
  XFile? pickedImage;
  FToast fToast = FToast();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });

    _controller.document.changes.listen((event) {
      setState(() {});
    });

    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus && !_quillFocusNode.hasFocus) {
        _titleFocusNode.requestFocus();
      }
    });
    _quillFocusNode.addListener(() {
      if (!_quillFocusNode.hasFocus && !_titleFocusNode.hasFocus) {
        _titleFocusNode.requestFocus();
      }
    });
    super.initState();
  }

  Future<String?> pickImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    return picked?.path;
  }

  Future<void> onCustomInsertImagePressed(
    BuildContext context,
    QuillController controller,
  ) async {
    final imageConfig = QuillToolbarImageConfig(
      onRequestPickImage: pickImageFromGallery,
      onImageInsertCallback: (imageUrl, controller) async {
        final index = controller.selection.baseOffset;
        controller.replaceText(index, 0, BlockEmbed.image(imageUrl), null);
      },
      onImageInsertedCallback: (imageUrl) async {
        debugPrint('이미지 삽입 완료: $imageUrl');
      },
    );

    final imageUrl = await imageConfig.onRequestPickImage?.call(context);

    if (imageUrl != null) {
      await imageConfig.onImageInsertCallback?.call(imageUrl, controller);
      await imageConfig.onImageInsertedCallback?.call(imageUrl);
    }
  }

  bool isImageIncluded() {
    List<dynamic> jsonData = _controller.document.toDelta().toJson();
    bool hasImage = jsonData.any((element) => element["insert"] is Map && element["insert"].containsKey("image"));
    return hasImage;
  }

  Future<void> scrapSave() async {
    var json = jsonEncode(_controller.document.toDelta().toJson());
    List<dynamic> decodedJson = jsonDecode(json);

    /// 맨뒤 링크만 있을 경우 포멧팅 에러가 있어서 \n 추가
    if (decodedJson.isNotEmpty && decodedJson.last['insert'] == "\n") {
      decodedJson.last['insert'] = "\n\n";
    }

    /// 수정된 리스트를 다시 JSON 문자열로 인코딩
    var modifiedJson = jsonEncode(decodedJson);
    bool hasImage = isImageIncluded();

    // 상태 갱신
    _scrapCreateController.scrapCreateState = _scrapCreateController.state.copyWith(
      title: titleCon.text.trim(),
      content: modifiedJson,
      photoList: [],
    );

    await _scrapCreateController.onSavePressed();
    // await ss.createScrap(
    //     titleCon.text,
    //     modifiedJson,
    //     hasImage,
    //     '0x${colorList[selectedColor].value.toRadixString(16).toUpperCase()}',
    //     hasImage ? [ss.addImgUrl.split('?')[0]] : []);
  }

  @override
  Widget build(BuildContext context) {
    final plain = _controller.document.toPlainText().trimRight();
    final displayLength = plain.length;
    return GetBuilder<ScrapCreateController>(builder: (controller) {
      final state = controller.state;
      return Stack(
        children: [
          Scaffold(
            backgroundColor: context.color.white,
            resizeToAvoidBottomInset: false,
            appBar: TrailingBackAppBar(
              text: '스크랩',
              backTap: () async {
                // if (ss.addImgUrl.isNotEmpty)
                //   await ss.removeImage(ss.addImgUrl.value);
                Get.back();
              },
              svgPicture: SvgPicture.asset(
                'assets/icon/save.svg',
                fit: BoxFit.none,
              ),
              trailingTap: () {
                scrapSave();
              },
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 35),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleCon,
                      style: context.style.body1Normal.copyWith(fontWeight: FontWeight.w700),
                      focusNode: _titleFocusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: '제목을 입력해주세요',
                        hintStyle: context.style.body1Normal.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.color.gray300,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CommonDivider(),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: Get.height * 0.6,
                      ),
                      child: QuillEditor(
                        controller: _controller,
                        focusNode: _quillFocusNode,
                        scrollController: ScrollController(),
                        config: QuillEditorConfig(
                          scrollable: false,
                          expands: false,
                          autoFocus: false,
                          showCursor: true,
                          enableInteractiveSelection: true,
                          customStyles: DefaultStyles(),
                          embedBuilders: kIsWeb
                              ? FlutterQuillEmbeds.editorWebBuilders()
                              : FlutterQuillEmbeds.editorBuilders(
                                  imageEmbedConfig: QuillEditorImageEmbedConfig(
                                    onImageClicked: (node) {
                                      _controller.updateSelection(
                                        TextSelection(
                                          baseOffset: node.length,
                                          extentOffset: node.length,
                                        ),
                                        ChangeSource.local,
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 80),
                  ],
                ),
              ),
            ),
            bottomSheet: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPadding(
                  duration: const Duration(milliseconds: 20),
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.color.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -3),
                          blurRadius: 6,
                          spreadRadius: 0,
                          color: Color(0x1AD4D4D4),
                        ),
                        BoxShadow(
                          offset: Offset(0, -10),
                          blurRadius: 10,
                          spreadRadius: 0,
                          color: Color(0x17D4D4D4),
                        ),
                        BoxShadow(
                          offset: Offset(0, -23),
                          blurRadius: 14,
                          spreadRadius: 0,
                          color: Color(0x0DD4D4D4),
                        ),
                        BoxShadow(
                          offset: Offset(0, -40),
                          blurRadius: 16,
                          spreadRadius: 0,
                          color: Color(0x03D4D4D4),
                        ),
                        BoxShadow(
                          offset: Offset(0, -63),
                          blurRadius: 18,
                          spreadRadius: 0,
                          color: Color(0x00D4D4D4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        AppIconButton(
                          assetPath: IconConstants.photo,
                          color: context.color.gray900,
                          onTap: () {
                            onCustomInsertImagePressed(context, _controller);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showColorPicker = !showColorPicker;
                            });
                          },
                          child: Stack(
                            children: [
                              SvgIcon(
                                fit: BoxFit.fitWidth,
                                assetPath: IconConstants.dropper,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: state.getColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text('$displayLength', style: context.style.caption1),
                        Text(
                          '/1000',
                          style: context.style.caption1.copyWith(color: context.color.gray400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showColorPicker)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showColorPicker = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 48 + MediaQuery.of(context).viewInsets.bottom + 24,
                        left: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.color.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                            child: ColorSelectButton(
                              selectedColor: controller.state.selectedColor,
                              onSelected: (tripColor) {
                                controller.onColorPressed(tripColor);
                                setState(() {
                                  showColorPicker = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
