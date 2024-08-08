import 'package:flutter/material.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/setting/settingArrowRow.dart';
import 'package:tripStory/screen/myPage/editProfilePage.dart';
import 'package:tripStory/screen/myPage/settingPage.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List type = ['낭만주의 즉흥러', '문화 탐방형', '핫플 정복자', '마운틴 러버', '맛집 수집가'];
  List travelCountList = ['대한민국 (2)','일본 (3)', '그리스 (1)'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '마이페이지',onTap: (){Get.back();}),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            /// 프로필 사진 및 프로필
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 프로필 사진
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD9D9D9)
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: (){
                                Get.to(()=>EditProfilePage());
                                print('profile edit');
                              },
                              child: Container(
                                width: 31,
                                height: 32,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: Color(0xffECECEC))
                                ),
                                child: Icon(Icons.edit, size: 20,),
                              ),
                            ),
                          )
                        ],),
                      const SizedBox(width: 15,),
                      /// 닉네임
                      Container(
                          height: 95,
                          child: Center(child: Text('김여행', style: f20gray800w700))),
                      Spacer(),
                      /// 알람
                      GestureDetector(
                        onTap: (){
                        },
                        child: Container(
                          color: Colors.red,
                          width: 19,
                          height: 19.43,
                          child: FittedBox(
                            fit: BoxFit.cover,
                              child: Icon(Icons.notifications_outlined, )),
                        ),
                      ),
                      SizedBox(width: 16,),
                      /// 설정
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>SettingPage());
                        },
                        child: Container(
                          color: Colors.red,
                          width: 19,
                          height: 19.43,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(Icons.settings_outlined,)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 38,),
                  /// 여행 유형
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 6,
                    runSpacing: 10,
                    children: type.map<Widget>((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3.5),
                        decoration: BoxDecoration(
                          color: gray200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '# ${item}',
                          style: f14gray600w500
                        ),
                      );
                    }).toList(
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 11,
              color: lightGray1,
            ),
            /// 다녀온 여행지
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 28),
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
              thickness: 11,
              color: lightGray1,
            ),
            /// 친구초대
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 31, bottom: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('친구초대', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  SettingArrowRow(
                      title: '추천하기',
                      onTap: (){print('추천하기');
                  }),
                  SizedBox(height: 20,),
                  SettingArrowRow(
                      title: '초대코드 입력',
                      onTap: (){print('초대코드 입력');
                      }),
                ],
              ),
            ),
            Divider(
              thickness: 11,
              color: lightGray1,
            ),
            /// 이용 안내
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 31, bottom: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('이용 안내', style: f20gray800w700,),
                  const SizedBox(height: 28,),
                  SettingArrowRow(
                      title: '공지사항',
                      onTap: (){print('공지사항');
                      }),
                  const SizedBox(height: 20,),
                  SettingArrowRow(
                      title: '이벤트',
                      onTap: (){print('이벤트');
                      }),
                  const SizedBox(height: 20,),
                  SettingArrowRow(
                      title: 'FAQ',
                      onTap: (){print('FAQ');
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
