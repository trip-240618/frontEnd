import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/util/extension/color_extension.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/scrap_create_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/scrap_create_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/scrap_create_state.dart';

class ScrapCreateController extends GetxController with GetSingleTickerProviderStateMixin {
  final TripRoomService _tripRoomService;
  final ScrapCreateUseCase _scrapCreateUseCase;

  ScrapCreateController(this._tripRoomService, this._scrapCreateUseCase);

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  ScrapCreateState scrapCreateState = ScrapCreateState();

  ScrapCreateState get state => scrapCreateState;

  final QuillController quillController = QuillController.basic();
  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode quillFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  int get displayLength => quillController.document.toPlainText().trimRight().length;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    // Quill 문서 변경 감지
    quillController.document.changes.listen((event) {
      update();
    });

    // Focus 관리
    titleFocusNode.addListener(() {
      if (!titleFocusNode.hasFocus && !quillFocusNode.hasFocus) {
        titleFocusNode.requestFocus();
      }
    });

    quillFocusNode.addListener(() {
      if (!quillFocusNode.hasFocus && !titleFocusNode.hasFocus) {
        titleFocusNode.requestFocus();
      }
    });
  }

  void toggleColorPicker() {
    scrapCreateState = state.copyWith(
      isShowColorPicker: !state.isShowColorPicker,
    );
    update();
  }

  void hideColorPicker() {
    scrapCreateState = state.copyWith(
      isShowColorPicker: false,
    );
    update();
  }

  void onColorPressed(
    TripColor selectedColor,
  ) {
    scrapCreateState = state.copyWith(
      selectedColor: selectedColor,
      isShowColorPicker: false,
    );
    update();
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

  bool _isImageIncluded() {
    List<dynamic> jsonData = quillController.document.toDelta().toJson();
    return jsonData.any(
      (element) => element["insert"] is Map && element["insert"].containsKey("image"),
    );
  }

  String _getFormattedJsonContent() {
    var json = jsonEncode(quillController.document.toDelta().toJson());
    List<dynamic> decodedJson = jsonDecode(json);

    // 맨 뒤 링크만 있을 경우 포맷팅 에러 방지
    if (decodedJson.isNotEmpty && decodedJson.last['insert'] == "\n") {
      decodedJson.last['insert'] = "\n\n";
    }

    return jsonEncode(decodedJson);
  }

  Future<void> onSavePressed() async {
    scrapCreateState = state.copyWith(
      showLoading: OneTimeEvent(true),
    );
    update();

    if (_isImageIncluded()) {
      // final bytes = await state.roomImage?.readAsBytes();
      // final compressByte = await ImageFileUtil.compressBytes(bytes!);
      // thumbBytes = compressByte;
    }

    final entity = ScrapCreateEntity(
      title: state.title,
      content: state.content,
      hasImage: state.hasImage,
      color: state.getColor.toJson(),
      photoList: state.photoList,
    );

    final tripId = tripRoomInfo?.id;

    if (tripId == null) return;

    final result = await _scrapCreateUseCase(
      Tuple2(
        tripId,
        entity,
      ),
    );

    result.fold(
      (failure) {
        scrapCreateState = state.copyWith(
          showLoading: OneTimeEvent(false),
        );
      },
      (createdScrap) {
        scrapCreateState = state.copyWith(
          showLoading: OneTimeEvent(false),
        );
      },
    );
    update();
  }

  @override
  void onClose() {
    quillController.dispose();
    titleController.dispose();
    titleFocusNode.dispose();
    quillFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
