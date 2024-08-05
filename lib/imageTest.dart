import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
        children: [
          Text('캐시드 이미지'),
          Container(
            width: 65,
            color: Colors.red,
            height: 65,
            child: CachedNetworkImage(
              imageUrl: 'https://via.placeholder.com/200x150',
              //imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2F${ss.signUpList[0]['docId']}?alt=media',
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }

}
