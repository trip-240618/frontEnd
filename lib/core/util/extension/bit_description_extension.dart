import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension BitDescriptionExtension on Widget {
  Future<BitmapDescriptor> toBitmapDescriptor({
    Size? logicalSize,
    Size? imageSize,
    Duration waitToRender = const Duration(milliseconds: 200),
    TextDirection textDirection = TextDirection.ltr,
  }) async {
    final widget = RepaintBoundary(
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: this,
        ),
      ),
    );

    final view = ui.PlatformDispatcher.instance.views.first;

    final pngBytes = await _createImageFromWidget(
      widget,
      waitToRender: waitToRender,
      view: view,
      logicalSize: logicalSize,
      imageSize: imageSize,
    );

    return BitmapDescriptor.bytes(pngBytes, imagePixelRatio: view.devicePixelRatio);
  }
}

/// 주어진 위젯으로부터 이미지를 생성합니다.
/// 내부적으로는 임시 element/render tree(렌더 트리)를 만들어 띄운 뒤,
/// [waitToRender] 동안 대기하여 네트워크 이미지나 에셋 이미지처럼
/// 렌더링에 시간이 걸리는 위젯들이 제대로 그려지도록 합니다.
///
/// 최종 결과 이미지 크기는 [imageSize]가 되며,
/// 위젯은 [logicalSize]를 기준으로 레이아웃되고 그려집니다.
/// 특별히 지정하지 않으면 [imageSize]와 [logicalSize]는
/// 앱 메인 윈도우 크기를 기반으로 자동 계산됩니다.

Future<Uint8List> _createImageFromWidget(
  Widget widget, {
  Size? logicalSize,
  required Duration waitToRender,
  required ui.FlutterView view,
  Size? imageSize,
}) async {
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
  logicalSize ??= view.physicalSize / view.devicePixelRatio;
  imageSize ??= view.physicalSize;

  final RenderView renderView = RenderView(
    view: view,
    child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
    configuration: ViewConfiguration(
      physicalConstraints: BoxConstraints.tight(logicalSize) * view.devicePixelRatio,
      logicalConstraints: BoxConstraints.tight(logicalSize),
      devicePixelRatio: view.devicePixelRatio,
    ),
  );

  final PipelineOwner pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);

  await Future.delayed(waitToRender);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final ui.Image image = await repaintBoundary.toImage(pixelRatio: imageSize.width / logicalSize.width);
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
