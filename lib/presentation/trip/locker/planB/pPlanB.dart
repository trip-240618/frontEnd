import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/pPlanState.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/font.dart';

import '../../../../component/button/plusFloating.dart';
import '../../../../component/dialog/daySelect.dart';
import '../../../../component/textForm/textform.dart';
import '../../../../controller/tripState.dart';

class PPlanB extends StatefulWidget {
  const PPlanB({super.key});

  @override
  State<PPlanB> createState() => _PPlanBState();
}

class _PPlanBState extends State<PPlanB> {
  final ps = Get.put(PPlanState());
  final ts = Get.put(TripState());
  bool isLoading = true;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ps.getPlanBPList();
      isLoading = false;
      setState(() {});
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        removeLastPlan();
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  /// 포커스를 벗어나면 임시 추가된 빈 일정 항목을 삭제
  void removeLastPlan() {
    var lastPlan = ps.planBPList[0]['dayList'][0]['planList'].last;
    if (lastPlan['planId'] == null) {
      ps.planBPList[0]['dayList'][0]['planList'].removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_focusNode.hasFocus) {
          FocusScope.of(context).unfocus();
        }
        setState(() {});
      },
      child: isLoading
          ? SizedBox()
          : Obx(() => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: gray50,
              body: Padding(
                padding: const EdgeInsets.only(top: 32, left: 20, right: 20),
                child: Column(
                  children: [
                    ps.planBPList[0]['dayList'].isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: ps.planBPList[0]['dayList'][0]['planList'].length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return AbsorbPointer(
                                absorbing: _focusNode.hasFocus,
                                child: Column(
                                  key: Key('${index}'),
                                  children: [
                                    Row(children: [
                                      SvgPicture.asset(
                                        'assets/icon/unchecked.svg',
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '${ps.planBPList[0]['dayList'][0]['planList'][index]['content']}',
                                        style: f14gray800w700,
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: PopupMenuButton<int>(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            side: BorderSide(color: gray200),
                                          ),
                                          iconSize: 1,
                                          offset: const Offset(-4, 20),
                                          padding: EdgeInsets.zero,
                                          menuPadding: EdgeInsets.zero,
                                          constraints: BoxConstraints(maxWidth: 125),
                                          shadowColor: Colors.black.withOpacity(0.4),
                                          icon: SvgPicture.asset('assets/icon/rowEllipsis.svg'),
                                          color: gray50,
                                          itemBuilder: (context) => <PopupMenuEntry<int>>[
                                            PopupMenuItem<int>(
                                              onTap: () async {
                                                ps.selectPlanBPList.value =
                                                    ps.planBPList[0]['dayList'][0]['planList'][index];
                                                _controller.text = ps.selectPlanBPList['content'];
                                                TextFormSheet(context, '여행일정을 입력해주세요', _controller, _focusNode,
                                                    () async {
                                                  if (_controller.text != '') {
                                                    ps.selectPlanBPList['content'] = _controller.text;
                                                    await ps.editPPlanList(ps.selectPlanBPList.value);
                                                    await ps.getPlanBPList();
                                                  }
                                                });
                                                await Future.delayed(Duration(milliseconds: 100));
                                                _focusNode.requestFocus();
                                              },
                                              padding: EdgeInsets.zero,
                                              value: 1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icon/pencil.svg',
                                                          colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                          fit: BoxFit.none,
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Text(
                                                          '일정 수정',
                                                          style: f14Gray800w500,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuDivider(height: 1),
                                            PopupMenuItem<int>(
                                              onTap: () async {
                                                await ps.deletePPlan(
                                                    ps.planBPList[0]['dayList'][0]['planList'][index]['planId'], -1);
                                                await ps.getPlanBPList();
                                              },
                                              padding: EdgeInsets.zero,
                                              value: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 24,
                                                      height: 24,
                                                      child: SvgPicture.asset(
                                                        'assets/icon/trashCan.svg',
                                                        fit: BoxFit.none,
                                                        colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      '일정 삭제',
                                                      style: f14Gray800w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const PopupMenuDivider(height: 1),
                                            PopupMenuItem<int>(
                                              onTap: () async {
                                                ps.selectPlanBPList.value =
                                                    ps.planBPList[0]['dayList'][0]['planList'][index];
                                                ps.selectPlanBPList['locker'] = false;
                                                ButtonSelectDayBottomSheet(context, '일정이동시 날짜 지정이 필요해요', '일정이동');
                                              },
                                              padding: EdgeInsets.zero,
                                              value: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 24,
                                                      height: 24,
                                                      child: SvgPicture.asset(
                                                        'assets/bottomNavi/schedule.svg',
                                                        fit: BoxFit.none,
                                                        colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      '일정 이동',
                                                      style: f14Gray800w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              floatingActionButton: _focusNode.hasFocus
                  ? SizedBox()
                  : PlusFloatingButton(
                      backgroundColor: gray900,
                      onPressed: () async {
                        if (ps.planBPList[0]['dayList'].isEmpty) {
                          ps.planBPList[0]['dayList'].add({'day': 0, 'planList': []});
                        }
                        ps.planBPList[0]['dayList'][0]['planList'].add({
                          'planId': null,
                          'writerUuid': '',
                          'content': '',
                          'checkbox': false,
                        });
                        _controller.clear();
                        TextFormSheet(context, '여행일정을 입력해주세요', _controller, _focusNode, () async {
                          ps.planBPList[0]['dayList'][0]['planList'].removeLast();
                          Map data = {"content": '${_controller.text}', "locker": true};
                          await ps.addPPlanList(data);
                          await ps.getPlanBPList();
                        });
                        await Future.delayed(Duration(milliseconds: 100));
                        _focusNode.requestFocus();
                        setState(() {});
                      },
                    ))),
    );
  }
}
