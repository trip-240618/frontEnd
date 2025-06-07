import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/image_button.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/button/typeChoose.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/hoom/controller/trip_rooms_create_controller.dart';
import 'package:tripStory/view/hoom/tripAdd/tripCalendar.dart';

class TripRoomCreateView extends StatefulWidget {
  const TripRoomCreateView({super.key});

  @override
  State<TripRoomCreateView> createState() => _TripRoomCreateViewState();
}

class _TripRoomCreateViewState extends State<TripRoomCreateView> {
  final _tripRoomsCreateController = Get.find<TripRoomsCreateController>();

  final TextEditingController _tripNameCon = TextEditingController();

  /// 여행방 입력
  List colorList = [pastelBlue, mainRed, yellowColor, greenColor];
  int selectedColor = 0;
  String tripType = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tripRoomsCreateController.precacheFlags(context);
    });
  }

  @override
  void dispose() {
    _tripNameCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripRoomsCreateController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(
          text: '여행방 만들기',
          onTap: () => Get.back(),
        ),
        body: Column(
          children: [
            Container(
              color: gray50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    ImageButton(
                      pickedImage: controller.tripRoomCreateState.roomImage,
                      onPressed: () => _tripRoomsCreateController.onImagePressed(
                        ImageSource.gallery,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: gray200)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: TextFormFieldComponent(
                                controller: _tripNameCon,
                                hintText: '여행방 제목을 입력해주세요 :)',
                                onChanged: (v) {
                                  setState(() {});
                                },
                                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${_tripNameCon.text.length}/15', style: f11Gray400w600)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '아이콘 컬러',
                          style: f12gray600w600,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: Get.width,
                          height: 24,
                          child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selectedColor = index;
                                      setState(() {});
                                    },
                                    child: selectedColor == index
                                        ? Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: gray900, width: 2),
                                                color: colorList[index]),
                                            child: SvgPicture.asset(
                                              'assets/icon/checkIcon.svg',
                                              fit: BoxFit.none,
                                            ),
                                          )
                                        : Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: colorList[index]),
                                          ),
                                  ),
                                  const SizedBox(width: 12)
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          '여행방 타입',
                          style: f12gray600w600,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TypeChoose(
                                  text: 'J형',
                                  onTap: () {
                                    tripType = 'J형';
                                    setState(() {});
                                  },
                                  value: tripType),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TypeChoose(
                                  text: 'P형',
                                  onTap: () {
                                    tripType = 'P형';
                                    setState(() {});
                                  },
                                  value: tripType),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '여행 날짜',
                          style: f12gray600w600,
                        ),
                        const SizedBox(height: 8),
                        Obx(() => GestureDetector(
                              onTap: () async {
                                Get.to(() => TripCalendar(
                                      selectedColor: colorList[selectedColor],
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: gray50,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: gray200)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/date.svg',
                                          fit: BoxFit.none,
                                          colorFilter: ColorFilter.mode(colorList[selectedColor], BlendMode.srcIn)),
                                      const SizedBox(width: 4),
                                      // ms.tripDate.isEmpty
                                      //     ? Text(
                                      //         '여행 날짜를 입력해 주세요',
                                      //         style: f15gray400w500,
                                      //       )
                                      //     : Text(
                                      //         ms.tripDate.length == 1
                                      //             ? '${DateFormat('yyyy-MM-dd').format(ms.tripDate[0])}'
                                      //             : '${DateFormat('yyyy-MM-dd').format(ms.tripDate[0])} ~ ${DateFormat('yyyy-MM-dd').format(ms.tripDate[1])}',
                                      //         style: f15gray800w500,
                                      //       )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Text(
                          '여행지',
                          style: f12gray600w600,
                        ),
                        const SizedBox(height: 8),
                        Obx(() => GestureDetector(
                              onTap: () async {
                                // await ms.bottomModalReset();
                                // bottomModel(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: gray50,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: gray200)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/search.svg',
                                          fit: BoxFit.none,
                                          colorFilter: ColorFilter.mode(colorList[selectedColor], BlendMode.srcIn)),
                                      const SizedBox(width: 4),
                                      // ms.tripDestination.value == ''
                                      //     ? Text('여행지를 입력해 주세요', style: f15gray400w500)
                                      //     : Text(
                                      //         '${ms.tripDestination.value}',
                                      //         style: f15gray800w500,
                                      //       )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
        //     child: Obx(() => BottomContainer(
        //         onTap: () async {
        //           if (tripName.text.trim().isEmpty || tripType == '' || ms.tripDate.isEmpty || ms.tripDestination == '') {
        //             showOnlyConfirmTapDialog(context, '여행방 정보를 전부 입력해주세요', () {
        //               Get.back();
        //             });
        //           } else {
        //             showLoading(context);
        //             String thumbnailUrl = '';
        //             if (pickedImage != null) {
        //               Map<String, dynamic> thumbnailData = await ms.tripThumbnailUpload(pickedImage!);
        //               thumbnailUrl = thumbnailData['preSignedUrls'][0].toString().split('?')[0];
        //             }
        //             Map<String, dynamic> createData = await ms.createRoom(
        //                 thumbnailUrl,
        //                 tripName.text,
        //                 '0x${colorList[selectedColor].value.toRadixString(16).toUpperCase()}',
        //                 tripType,
        //                 ms.tripDate,
        //                 ms.tripDestination.value);
        //             if (createData.isNotEmpty) {
        //               await ts.getSelectTrip(createData['tripId']);
        //               Get.back();
        //               CodeDialog(context, createData['tripId'], createData['invitationCode']);
        //             }
        //           }
        //         },
        //         title: '저장',
        //         isBlack: ms.tripDate.isEmpty ||
        //                 tripName.text.trim().isEmpty ||
        //                 tripType == '' ||
        //                 ms.tripDestination.value == ''
        //             ? false
        //             : true))),
      );
    });
  }
}
