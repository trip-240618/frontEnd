import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Future<Uint8List> createImageFromWidget(
    Widget widget, {
      Size? logicalSize,
      Duration waitToRender = const Duration(milliseconds: 300),
      Size? imageSize,
    }) async {
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
  final view = ui.PlatformDispatcher.instance.views.first;

  logicalSize ??= Size(view.physicalSize.width / view.devicePixelRatio, view.physicalSize.height / view.devicePixelRatio);
  imageSize ??= Size(view.physicalSize.width, view.physicalSize.height);

  assert(logicalSize.aspectRatio == imageSize.aspectRatio);

  final RenderView renderView = RenderView(
    view: view,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
    configuration: ViewConfiguration(
      // size: logicalSize,
      physicalConstraints: BoxConstraints(minHeight: 300,maxWidth: 300),
      logicalConstraints: BoxConstraints(minHeight: 300,maxWidth: 300),
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

  final ui.Image image = await repaintBoundary.toImage(
    pixelRatio: imageSize.width / logicalSize.width,
  );
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
