import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../component/history/customMarker.dart';
import 'color.dart';
import 'font.dart';
Future<BitmapDescriptor> getCustomIcon(int index, String imageUrl) async {
  final double iconSize = 300.0;

  final File imageFile = await DefaultCacheManager().getSingleFile(imageUrl);
  final Uint8List imageBytes = await imageFile.readAsBytes();

  final widget = SizedBox(
    width: iconSize,
    height: 400,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: blueColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Center(child: Text('$index', style: f28whitew700)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: Image.asset(
              "assets/icon/mapImage.png",
              width: iconSize,
              height: iconSize,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  final pngBytes = await createImageFromWidget(
    widget,
    logicalSize: Size(iconSize, iconSize),
    imageSize: Size(iconSize, iconSize),
  );

  return BitmapDescriptor.fromBytes(pngBytes);
}

Future<BitmapDescriptor> getCustomIcon2(int index) async {
  final double iconSize = 200.0;

  final widget = SizedBox(
    width: 80,
    height: 130,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Positioned(
           bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: blueColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Center(child: Text('$index', style: f28whitew700)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
              child: SvgPicture.asset('assets/icon/mapmarker.svg',width: 80,height: 80,fit: BoxFit.cover)),
        ],
      ),
    ),
  );

  final pngBytes = await createImageFromWidget(
    widget,
    logicalSize: Size(iconSize, iconSize),
    imageSize: Size(iconSize, iconSize),
  );

  return BitmapDescriptor.fromBytes(pngBytes);
}