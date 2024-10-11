import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/component/setting/settingArrowRow.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/myPage/editProfilePage.dart';
import 'package:tripStory/screen/myPage/faq/setting_faq_main.dart';
import 'package:tripStory/screen/myPage/setting/setting_main_page.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';

import 'notice/setting_noti_main.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List type = ['낭만주의 즉흥러', '문화 탐방형', '핫플 정복자', '마운틴 러버', '맛집 수집가'];
  List travelCountList = ['대한민국 (2)','일본 (3)', '그리스 (1)'];
  final us = Get.put(UserState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrailingBackAppBar(
        text: '마이 페이지',
        backTap: (){Get.back();},
        svgPicture: SvgPicture.asset('assets/icon/setting.svg',fit: BoxFit.none,),
        trailingTap: (){
          Get.to(()=>SettingMainPage());
        },
        color: Colors.white,),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            /// 프로필 사진 및 프로필
            GestureDetector(
              onTap: (){
                Get.to(()=>EditProfilePage());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 프로필 사진
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 98,
                            height: 98,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Color(0xffD9D9D9)
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(width: 1, color: Color(0xffECECEC))
                                    ),
                                    child: SvgPicture.asset('assets/icon/pencil.svg',fit: BoxFit.none,colorFilter: ColorFilter.mode(gray500,BlendMode.srcIn)),
                                  ),
                                )
                              ],),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        /// 닉네임
                        Obx(()=>Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${us.userList[0]['nickName']}', style: f20gray800w700),
                              const SizedBox(height: 12),
                              Text('${us.userList[0]['memo']}')
                            ],
                          ),
                        ))
                      ],
                    ),
                    // const SizedBox(height: 38,),
                    // /// 여행 유형
                    // Wrap(
                    //   direction: Axis.horizontal,
                    //   alignment: WrapAlignment.start,
                    //   runAlignment: WrapAlignment.start,
                    //   spacing: 6,
                    //   runSpacing: 10,
                    //   children: type.map<Widget>((item) {
                    //     return Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3.5),
                    //       decoration: BoxDecoration(
                    //         color: gray200,
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       child: Text(
                    //         '# ${item}',
                    //         style: f14gray600w500
                    //       ),
                    //     );
                    //   }).toList(
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('다녀온 여행지', style: f20gray800w700,),
                  const SizedBox(height: 15,),
                  /// 국내, 해외
                  Row(
                    children: [
                      Text('국내 2',
                          style: f14bluew600
                      ),
                      const SizedBox(width: 12,),
                      Text('해외 4',
                        style: f14redw600,
                      ),
                    ],
                  ),
                  SizedBox(height: 31,),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: travelCountList.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Row(
                              children: [
                                /// 국가 이미지
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffD9D9D9)
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Text(
                                  '${travelCountList[index]}',
                                  style: f16gray800w600,
                                ),
                              ],
                            ),
                            index!=travelCountList.length-1? const SizedBox(height: 24,):const SizedBox(height: 28,)
                          ],
                        );
                      }),
                ],
              ),
            ),
            Divider(
              thickness: 6,
              color: lightGray1,
            ),
            /// 앱초대
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 20,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('앱 초대', style: f20gray800w700,),
                  const SizedBox(height: 16,),
                  SettingArrowRow(
                      title: '초대 링크 보내기',
                      onTap: (){
                        appSendBottomModal(context, 'dada');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            Divider(
              thickness: 6,
              color: lightGray1,
            ),
            /// 이용 안내
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 20, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('이용 안내', style: f20gray800w700,),
                  const SizedBox(height: 16,),
                  SettingArrowRow(
                      title: '공지사항',
                      onTap: (){
                        Get.to(()=>SettingNotiMain());
                      }),
                  const SizedBox(height: 16,),
                  SettingArrowRow(
                      title: 'FAQ',
                      onTap: (){
                        Get.to(()=>SettingFaqMain());
                      }),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
