import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  DemoAppState createState() => DemoAppState();
}

class DemoAppState extends State<DemoApp> {
  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Share Plus Plugin Demo'),
          elevation: 4,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share text',
                  hintText: 'Enter some text and/or link to share',
                ),
                maxLines: null,
                onChanged: (String value) => setState(() {
                  text = value;
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share subject',
                  hintText: 'Enter subject to share (optional)',
                ),
                maxLines: null,
                onChanged: (String value) => setState(() {
                  subject = value;
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share uri',
                  hintText: 'Enter the uri you want to share',
                ),
                maxLines: null,
                onChanged: (String value) {
                  setState(() => uri = value);
                },
              ),
              const SizedBox(height: 16),
              // ImagePreviews(imagePaths, onDelete: _onDeleteImage),
              ElevatedButton.icon(
                label: const Text('Add image'),
                onPressed: () async {
                  print('313');
                  imageDownload();
                  // final imagePicker = ImagePicker();
                  // final pickedFile = await imagePicker.pickImage(
                  //   source: ImageSource.gallery,
                  // );
                  // if (pickedFile != null) {
                  //   setState(() {
                  //     imagePaths.add(pickedFile.path);
                  //     imageNames.add(pickedFile.name);
                  //   });
                  // }
                },
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 32),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: text.isEmpty && imagePaths.isEmpty
                        ? null
                        : () => _onShareWithResult(context),
                    child: const Text('Share'),
                  );
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      _onShareXFileFromAssets(context);
                    },
                    child: const Text('Share XFile from Assets'),
                  );
                },
              ),
            ],
          ),
        ));

  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
      imageNames.removeAt(position);
    });
  }

  void _onShareWithResult(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ShareResult shareResult;
    if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      shareResult = await Share.shareXFiles(
        files,
        text: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
    // else if (uri.isNotEmpty) {
    //   shareResult = await Share.shareUri(
    //     Uri.parse(uri),
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    //   );
    // } else {
    //   shareResult = await Share.share(
    //     text,
    //     subject: subject,
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    //   );
    // }
    // scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  void _onShareXFileFromAssets(BuildContext context) async {

    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load('assets/flutter_logo.png');
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'flutter_logo.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  /// 사진 공유하기
  Future<void> imageDownload ()async{
    ShareResult shareResult;
    final box = context.findRenderObject() as RenderBox?;
    final http.Response responseData = await http.get(Uri.parse('https://trip-story-bucket.s3.amazonaws.com/test/%ED%8F%AC%EC%BC%93%EB%A1%9C%EA%B7%B8-2024%EB%85%84-7%EC%9B%94-%EC%A0%84%EC%84%A4-%EB%BD%91%EA%B8%B0-%ED%83%80%EA%B2%9F-%ED%8F%AC%EC%BC%93%EB%AA%AC.webp'));

    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);

    var tempDir = await getTemporaryDirectory();
    final files = <XFile>[];
    File file = await File('${tempDir.path}/img.jpg').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    XFile xfile = XFile(file.path);
    files.add(xfile);

    shareResult = await Share.shareXFiles(
      files,
      text: '',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
