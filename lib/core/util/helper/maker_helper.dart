import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerHelper {
  static final Map<String, BitmapDescriptor> _cache = {};

  static Future<BitmapDescriptor> loadCustomMarker(String assetPath) async {
    if (_cache.containsKey(assetPath)) return _cache[assetPath]!;

    final icon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      assetPath,
    );
    _cache[assetPath] = icon;
    return icon;
  }

  static Marker createMarker({
    required String id,
    required LatLng position,
    required BitmapDescriptor icon,
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      onTap: onTap,
    );
  }

  static Future<BitmapDescriptor> renderWidgetIcon({
    required Widget widget,
    required Size logicalSize,
    String? cacheKey,
    Duration waitToRender = const Duration(milliseconds: 200),
  }) async {
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    final bytes = await _renderWidgetToPng(
      widget: Directionality(
        textDirection: TextDirection.ltr,
        child: widget,
      ),
      waitToRender: waitToRender,
    );

    final icon = BitmapDescriptor.fromBytes(bytes);
    if (cacheKey != null) _cache[cacheKey] = icon;
    return icon;
  }

  static Future<Uint8List> _renderWidgetToPng({
    required Directionality widget,
    Duration waitToRender = const Duration(milliseconds: 300),
  }) async {
    Size? logicalSize;
    Size? imageSize;

    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    final view = ui.PlatformDispatcher.instance.views.first;

    logicalSize ??=
        Size(view.physicalSize.width / view.devicePixelRatio, view.physicalSize.height / view.devicePixelRatio);
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
        physicalConstraints: BoxConstraints(minHeight: 300, maxWidth: 300),
        logicalConstraints: BoxConstraints(minHeight: 300, maxWidth: 300),
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
}
