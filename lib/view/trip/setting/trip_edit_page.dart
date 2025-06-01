import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/main/main_page/views/rooms_view.dart';

class TripEditPage extends StatefulWidget {
  const TripEditPage({super.key});

  @override
  State<TripEditPage> createState() => _TripEditPageState();
}

class _TripEditPageState extends State<TripEditPage> {
  final ts = Get.put(TripState());
  final ms = Get.put(MainState());
  final List<Map<String, dynamic>> countries = [
    {
      'region': '국내',
      'countries': [
        {
          'name': '대한민국',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/241/20220224_233513043.gif'
        },
      ],
    },
    {
      'region': '아시아',
      'countries': [
        {
          'name': '일본',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/176/20220318_162955741.gif'
        },
        {
          'name': '중국',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/182/20220329_151915812.gif'
        },
        {
          'name': '대만',
          'image': 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/taiwan.png?alt=media'
        },
        {
          'name': '홍콩',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/250/20220224_233512982.gif'
        },
        {
          'name': '몽골',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/80/20220318_164338924.gif'
        },
        {
          'name': '러시아',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/50/20220729_092800113.png'
        },
        {
          'name': '인도네시아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/175/20220318_162536716.gif'
        },
        {
          'name': '미얀마',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/82/20220318_164314751.gif'
        },
        {
          'name': '태국',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/214/20220318_170222070.gif'
        },
        {
          'name': '베트남',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/92/20220318_170753486.gif'
        },
        {
          'name': '말레이시아',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/66/20220318_164600046.gif'
        },
        {
          'name': '필리핀',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/237/20220318_165139676.gif'
        },
        {
          'name': '라오스',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/47/20220318_163332591.gif'
        },
        {
          'name': '캄보디아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/194/20220318_163118134.jpg'
        },
        {
          'name': '싱가포르',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/133/20220318_165655208.gif'
        },
        {
          'name': '네팔',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/35/20220318_164857163.gif'
        },
        {
          'name': '몰디브',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/78/20220318_164502026.gif'
        },
        {
          'name': '방글라데시',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/88/20220318_155428211.gif'
        },
        {
          'name': '부탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/101/20220318_155946652.gif'
        },
        {
          'name': '스리랑카',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/125/20220318_163456971.gif'
        },
        {
          'name': '아프가니스탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/142/20220318_154306906.gif'
        },
        {
          'name': '이란',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/170/20220318_162755203.gif'
        },
        {
          'name': '인도',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/174/20220318_162705650.gif'
        },
        {
          'name': '파키스탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/225/20220318_165158778.gif'
        },
        {
          'name': '우즈베키스탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/167/20220318_170638365.gif'
        },
        {
          'name': '카자흐스탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/192/20220318_163310295.gif'
        },
        {
          'name': '키르기스스탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/209/20220318_163048531.gif'
        },
        {
          'name': '타지키스탄',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/212/20220318_170239649.gif'
        },
        {
          'name': '바레인',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/84/20220318_155707078.gif'
        },
        {
          'name': '사우디아라비아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/108/20220318_165528053.gif'
        },
        {
          'name': '시리아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/131/20220318_170052069.gif'
        },
        {
          'name': '아랍에미리트',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/134/20220318_154219608.gif'
        },
        {
          'name': '요르단',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/164/20220318_162932491.gif'
        },
        {
          'name': '이라크',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/169/20220318_162732536.gif'
        },
        {
          'name': '이스라엘',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/171/20220318_162634203.gif'
        },
        {
          'name': '튀르키예',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/216/20220318_170408650.gif'
        },
        {
          'name': '팔레스타인',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/228/20220318_165237143.gif'
        },
        {
          'name': '조지아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/181/20220318_161818196.gif'
        },
      ],
    },
    {
      'region': '유럽',
      'countries': [
        {
          'name': '포르투갈',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/230/20220318_165302991.gif'
        },
        {
          'name': '스페인',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/128/20220318_161418873.gif'
        },
        {
          'name': '세르비아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/115/20220318_165434935.gif'
        },
        {
          'name': '슬로베니아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/130/20220318_165717405.gif'
        },
        {
          'name': '그리스',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/24/20220720_160223089.gif'
        },
        {
          'name': '크로아티아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/208/20220318_162351871.gif'
        },
        {
          'name': '이탈리아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/173/20220318_162836837.gif'
        },
        {
          'name': '노르웨이',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/36/20220318_164831540.gif'
        },
        {
          'name': '덴마크',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/42/20220318_160957995.gif'
        },
        {
          'name': '스웨덴',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/126/20220318_165639907.gif'
        },
        {
          'name': '아이슬란드',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/138/20220318_162816057.gif'
        },
        {
          'name': '아일랜드',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/140/20220318_162604484.gif'
        },
        {
          'name': '영국',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/155/20220318_161717544.gif'
        },
        {
          'name': '핀란드',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/236/20220318_161502305.gif'
        },
        {
          'name': '불가리아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/104/20220318_155644008.gif'
        },
        {
          'name': '슬로바키아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/129/20220318_165735565.gif'
        },
        {
          'name': '우크라이나',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/168/20220729_092922428.gif'
        },
        {
          'name': '체코',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/188/20220318_160834593.gif'
        },
        {
          'name': '폴란드',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/231/20220318_165216491.png'
        },
        {
          'name': '헝가리',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/239/20220318_162505062.gif'
        },
        {
          'name': '네덜란드',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/33/20220318_164807920.gif'
        },
        {
          'name': '독일',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/45/20220318_160907982.gif'
        },
        {
          'name': '룩셈부르크',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/55/20220318_163613450.gif'
        },
        {
          'name': '모나코',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/70/20220318_163730922.gif'
        },
        {
          'name': '벨기에',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/93/20220318_155559315.gif'
        },
        {
          'name': '스위스',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/127/20220318_160311962.gif'
        },
        {
          'name': '오스트리아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/161/20220318_155125077.gif'
        },
        {
          'name': '프랑스',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/232/20220318_161621275.gif'
        }
      ]
    },
    {
      'region': '아메리카',
      'countries': [
        {
          'name': '미국',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/81/20220504_170107685.jpg'
        },
        {
          'name': '멕시코',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/69/20220318_164538562.gif'
        },
        {
          'name': '과테말라',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/21/20220318_162216873.gif'
        },
        {
          'name': '캐나다',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/195/20220318_160107913.gif'
        },
        {
          'name': '쿠바',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/205/20220318_160637411.gif'
        },
        {
          'name': '브라질',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/105/20220318_155901021.gif'
        },
        {
          'name': '수리남',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/124/20220318_165905843.gif'
        },
        {
          'name': '아르헨티나',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/137/20220318_155042415.gif'
        },
        {
          'name': '에콰도르',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/152/20220318_161233228.gif'
        },
        {
          'name': '우루과이',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/166/20220318_170622175.gif'
        },
        {
          'name': '칠레',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/189/20220318_160418259.gif'
        },
        {
          'name': '콜롬비아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/202/20220318_160540028.gif'
        },
        {
          'name': '파라과이',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/224/20220318_165336804.gif'
        },
        {
          'name': '페루',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/229/20220318_165102133.gif'
        },
      ],
    },
    {
      'region': '오세아니아',
      'countries': [
        {
          'name': '오스트레일리아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/240/20220318_155159510.gif'
        },
        {
          'name': '뉴질랜드',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/38/20220318_165002661.gif'
        },
      ],
    },
    {
      'region': '아프리카',
      'countries': [
        {
          'name': '탄자니아',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/213/20220318_170507002.gif'
        },
        {
          'name': '콩고 민주 공화국',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/204/20220318_160137066.gif'
        },
        {
          'name': '가나',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/15/20220318_161935687.gif'
        },
        {
          'name': '세네갈',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/114/20220318_165832649.gif'
        },
        {
          'name': '토고',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/217/20220318_170156335.gif'
        },
        {
          'name': '알제리',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/145/20220318_161209334.gif'
        },
        {
          'name': '이집트',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/172/20220318_161328692.gif'
        },
        {
          'name': '리비아',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/57/20220318_163646072.gif'
        },
        {
          'name': '모로코',
          'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/71/20220318_163711153.gif'
        },
        {
          'name': '튀니지',
          'image':
              'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/221/20220318_170333269.gif'
        }
      ]
    }
  ];
  TextEditingController tripName = TextEditingController();

  /// 여행방 입력
  List colorList = [pastelBlue, mainRed, yellowColor, greenColor];
  int selectedColor = 0;
  XFile? pickedImage;
  String tripType = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      tripName.text = ts.selectTripList[0]['name'];
      selectedColor =
          colorList.indexWhere((color) => color.value == int.parse('${ts.selectTripList[0]['labelColor']}'));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: TrailingBackAppBar(
            text: '여행방 설정',
            backTap: () {
              Get.back();
            },
            svgPicture: SvgPicture.asset(
              'assets/icon/trashCan.svg',
              fit: BoxFit.none,
            ),
            trailingTap: () async {
              showConfirmCancelTapDialog(context, '여행방을 삭제하시겠습니까?\n삭제 후 복구는 어렵습니다', '확인', null, () async {
                showLoading(context);
                await ts.deleteTrip(ts.selectTripList[0]['id']);
                ms.selectIdx.value = 0;
                ms.selectIdx.refresh();
                Get.offAll(() => TripRoomListView());
              });
            },
          ),
          body: Column(
            children: [
              Container(
                color: gray50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          pickedImage = await ms.getSingleImage(ImageSource.gallery, context, pickedImage);
                          setState(() {});
                        },
                        child: pickedImage == null && ts.selectTripList[0]['thumbnail'] != ''
                            ? Center(
                                child: Container(
                                  width: 92,
                                  height: 92,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: ts.selectTripList[0]['thumbnail'],
                                          width: 80,
                                          height: 80,
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                            ),
                                          ),
                                          // placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                        ),
                                      ),
                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(4),
                                      //   child: Image.file(
                                      //     File(pickedImage!.path),
                                      //     width: 80,
                                      //     height: 80,
                                      //     fit: BoxFit.fill,
                                      //   ),
                                      // ),
                                      Positioned(bottom: 0, right: 0, child: SvgPicture.asset('assets/icon/plus.svg'))
                                    ],
                                  ),
                                ),
                              )
                            : pickedImage != null
                                ? Center(
                                    child: Container(
                                      width: 92,
                                      height: 92,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: Image.file(
                                              File(pickedImage!.path),
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 0, right: 0, child: SvgPicture.asset('assets/icon/plus.svg'))
                                        ],
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                      width: 92,
                                      height: 92,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Color(0xFFEEEEEE), // 색상 코드 #EEEEEE를 Flutter의 Color로 변환
                                                    width: 1.0, // border의 두께 (1px)
                                                  ),
                                                  borderRadius: BorderRadius.circular(4)),
                                              child:
                                                  Center(child: SvgPicture.asset('assets/icon/image.svg', width: 28)),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: SvgPicture.asset(
                                                'assets/icon/plus.svg',
                                              ))
                                        ],
                                      ),
                                    ),
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
                                  child: TextFormFieldComponent(
                                controller: tripName,
                                hintText: '여행방 제목을 입력해주세요',
                                onChanged: (v) {
                                  setState(() {});
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                ],
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${tripName.text.length}',
                                style: f11Gray800w600,
                              ),
                              Text(
                                '/15',
                                style: f11Gray600w600,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SvgPicture.asset('assets/icon/smallpencil.svg')
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
                                              decoration:
                                                  BoxDecoration(shape: BoxShape.circle, color: colorList[index]),
                                            ),
                                    ),
                                    const SizedBox(width: 12)
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '여행 날짜',
                            style: f12gray600w600,
                          ),
                          const SizedBox(height: 8),
                          Obx(() => GestureDetector(
                                onTap: () async {
                                  //Get.to(()=>TripCalendar(edit: true));
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: gray50, border: Border.all(color: gray200)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icon/date.svg',
                                            fit: BoxFit.none,
                                            colorFilter: ColorFilter.mode(colorList[selectedColor!], BlendMode.srcIn)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${ts.selectTripList[0]['startDate']} ~ ${ts.selectTripList[0]['endDate']}',
                                          style: f15gray800w500,
                                        )
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
                                  decoration: BoxDecoration(color: gray50, border: Border.all(color: gray200)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icon/search.svg',
                                            fit: BoxFit.none,
                                            colorFilter: ColorFilter.mode(colorList[selectedColor!], BlendMode.srcIn)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${ts.selectTripList[0]['country']}',
                                          style: f15gray800w500,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          // SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
            child: BottomContainer(
              onTap: () {
                showConfirmCancelTapDialog(context, '여행방 설정을 변경하시겠습니까?', '확인', null, () async {
                  String thumbnail = pickedImage != null
                      ? (await ms.tripThumbnailUpload(pickedImage!))['preSignedUrls'][0].toString().split('?')[0]
                      : ts.selectTripList[0]['thumbnail'];
                  await ts.modifyTrip(
                    ts.selectTripList[0]['id'],
                    tripName.text,
                    thumbnail,
                    '0x${colorList[selectedColor!].value.toRadixString(16).toUpperCase()}',
                    ts.selectTripList[0]['startDate'],
                    ts.selectTripList[0]['endDate'],
                  );
                  Get.back();
                  Get.back();
                });
              },
              title: '수정 완료',
              isBlack: true,
            ),
          ),
        ),
      ),
    );
  }
}
