
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class CameraMain extends StatefulWidget {
  const CameraMain({Key? key}) : super(key: key);

  @override
  State<CameraMain> createState() => _CameraMainState();
}

class _CameraMainState extends State<CameraMain> {
  TextEditingController _uidCon = TextEditingController();
  TextEditingController _idCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  TextEditingController _cameraNameCon = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  List _dataL = [];

  bool _isLoading = true;
  bool _listChange = false;
  List<bool> _cameraIconL = [
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List _filePath = [];
  int _currIndex = 1;
  bool _isInitializing = false;
  String headerEmail = '';
  bool changeClick = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currIndex==0?Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('이름/순서 변경'),
                  ),
                ):SizedBox(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    changeClick=!changeClick;
                    setState(() {
                      _currIndex = _currIndex == 0 ? 1 : 0;
                    });
                  },
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, anim) => RotationTransition(
                        turns: child.key == ValueKey('icon1')
                            ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                            : Tween<double>(begin: 0.75, end: 1).animate(anim),
                        child: ScaleTransition(scale: anim, child: child),
                      ),
                      child: _currIndex == 0
                          ? Icon(Icons.close, size: 32, key: const ValueKey('icon1'))
                          : Icon(
                        Icons.list,
                        size: 38,
                        key: const ValueKey('icon2'),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      buildDefaultDragHandles: false,
                      children: [
                        for (int index = 0; index < _dataL.length; index += 1)
                          Container(
                            key: Key('${index}'),
                            child: ReorderableDragStartListener(
                              enabled: _currIndex == 1 ? false : true,
                              index: index,
                              child: Container(
                                width: Get.width,
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black, width: 2)),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '1111',
                                              ),
                                              Spacer(),
                                            const SizedBox(
                                            height: 8,
                                            ),
                                            Text(
                                            'ㅇㅁㄴㅇㅁㄴ',
                                            // style: f13w500Grey(),
                                          ),
                                        ],
                                      ),
                                    ]),)
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                      onReorder: (int oldIndex, int newIndex) async {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item = _dataL.removeAt(oldIndex);
                          final item2 = _filePath.removeAt(oldIndex);
                          _dataL.insert(newIndex, item);
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

}
