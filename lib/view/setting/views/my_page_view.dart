import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/container/settingArrowRow.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/component/toast/toast.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/myPage/editProfilePage.dart';
import 'package:tripStory/view/myPage/faq/setting_faq_main.dart';
import 'package:tripStory/view/myPage/notice/setting_noti_main.dart';
import 'package:tripStory/view/myPage/setting/setting_main_page.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    super.key,
  });

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  /// 국기 그룹 리스트
  final List countries = [
    {
      'name': '대한민국',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/241/20220224_233513043.gif'
    },
    {
      'name': '일본',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/176/20220318_162955741.gif'
    },
    {
      'name': '중국',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/182/20220329_151915812.gif'
    },
    {
      'name': '대만',
      'image': 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/taiwan.png?alt=media'
    },
    {
      'name': '홍콩',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/250/20220224_233512982.gif'
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/175/20220318_162536716.gif'
    },
    {
      'name': '미얀마',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/82/20220318_164314751.gif'
    },
    {
      'name': '태국',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/214/20220318_170222070.gif'
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/237/20220318_165139676.gif'
    },
    {
      'name': '라오스',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/47/20220318_163332591.gif'
    },
    {
      'name': '캄보디아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/194/20220318_163118134.jpg'
    },
    {
      'name': '싱가포르',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/133/20220318_165655208.gif'
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/101/20220318_155946652.gif'
    },
    {
      'name': '스리랑카',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/125/20220318_163456971.gif'
    },
    {
      'name': '아프가니스탄',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/142/20220318_154306906.gif'
    },
    {
      'name': '이란',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/170/20220318_162755203.gif'
    },
    {
      'name': '인도',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/174/20220318_162705650.gif'
    },
    {
      'name': '파키스탄',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/225/20220318_165158778.gif'
    },
    {
      'name': '우즈베키스탄',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/167/20220318_170638365.gif'
    },
    {
      'name': '카자흐스탄',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/192/20220318_163310295.gif'
    },
    {
      'name': '키르기스스탄',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/209/20220318_163048531.gif'
    },
    {
      'name': '타지키스탄',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/212/20220318_170239649.gif'
    },
    {
      'name': '바레인',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/84/20220318_155707078.gif'
    },
    {
      'name': '사우디아라비아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/108/20220318_165528053.gif'
    },
    {
      'name': '시리아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/131/20220318_170052069.gif'
    },
    {
      'name': '아랍에미리트',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/134/20220318_154219608.gif'
    },
    {
      'name': '요르단',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/164/20220318_162932491.gif'
    },
    {
      'name': '이라크',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/169/20220318_162732536.gif'
    },
    {
      'name': '이스라엘',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/171/20220318_162634203.gif'
    },
    {
      'name': '튀르키예',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/216/20220318_170408650.gif'
    },
    {
      'name': '팔레스타인',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/228/20220318_165237143.gif'
    },
    {
      'name': '조지아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/181/20220318_161818196.gif'
    },
    {
      'name': '탄자니아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/213/20220318_170507002.gif'
    },
    {
      'name': '콩고 민주 공화국',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/204/20220318_160137066.gif'
    },
    {
      'name': '가나',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/15/20220318_161935687.gif'
    },
    {
      'name': '세네갈',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/114/20220318_165832649.gif'
    },
    {
      'name': '토고',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/217/20220318_170156335.gif'
    },
    {
      'name': '알제리',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/145/20220318_161209334.gif'
    },
    {
      'name': '이집트',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/172/20220318_161328692.gif'
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/221/20220318_170333269.gif'
    },
    {
      'name': '포르투갈',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/230/20220318_165302991.gif'
    },
    {
      'name': '스페인',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/128/20220318_161418873.gif'
    },
    {
      'name': '세르비아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/115/20220318_165434935.gif'
    },
    {
      'name': '슬로베니아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/130/20220318_165717405.gif'
    },
    {
      'name': '그리스',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/24/20220720_160223089.gif'
    },
    {
      'name': '크로아티아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/208/20220318_162351871.gif'
    },
    {
      'name': '이탈리아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/173/20220318_162836837.gif'
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/126/20220318_165639907.gif'
    },
    {
      'name': '아이슬란드',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/138/20220318_162816057.gif'
    },
    {
      'name': '아일랜드',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/140/20220318_162604484.gif'
    },
    {
      'name': '영국',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/155/20220318_161717544.gif'
    },
    {
      'name': '핀란드',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/236/20220318_161502305.gif'
    },
    {
      'name': '불가리아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/104/20220318_155644008.gif'
    },
    {
      'name': '슬로바키아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/129/20220318_165735565.gif'
    },
    {
      'name': '우크라이나',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/168/20220729_092922428.gif'
    },
    {
      'name': '체코',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/188/20220318_160834593.gif'
    },
    {
      'name': '폴란드',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/231/20220318_165216491.png'
    },
    {
      'name': '헝가리',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/239/20220318_162505062.gif'
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/127/20220318_160311962.gif'
    },
    {
      'name': '오스트리아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/161/20220318_155125077.gif'
    },
    {
      'name': '프랑스',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/232/20220318_161621275.gif'
    },
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
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/195/20220318_160107913.gif'
    },
    {
      'name': '쿠바',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/205/20220318_160637411.gif'
    },
    {
      'name': '브라질',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/105/20220318_155901021.gif'
    },
    {
      'name': '수리남',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/124/20220318_165905843.gif'
    },
    {
      'name': '아르헨티나',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/137/20220318_155042415.gif'
    },
    {
      'name': '에콰도르',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/152/20220318_161233228.gif'
    },
    {
      'name': '우루과이',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/166/20220318_170622175.gif'
    },
    {
      'name': '칠레',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/189/20220318_160418259.gif'
    },
    {
      'name': '콜롬비아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/202/20220318_160540028.gif'
    },
    {
      'name': '파라과이',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/224/20220318_165336804.gif'
    },
    {
      'name': '페루',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/229/20220318_165102133.gif'
    },
    {
      'name': '오스트레일리아',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/240/20220318_155159510.gif'
    },
    {
      'name': '뉴질랜드',
      'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/38/20220318_165002661.gif'
    },
  ];
  List myCountries = [];

  /// 내가 여행한 나라
  List type = ['낭만주의 즉흥러', '문화 탐방형', '핫플 정복자', '마운틴 러버', '맛집 수집가'];
  final us = Get.put(UserState());
  bool isLoading = true;
  FToast? fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    Future.delayed(Duration.zero, () async {
      await us.getCountrySetting();
      us.countryList.retainWhere((countryItem) {
        var matchingCountry = countries.firstWhere(
          (country) => country['name'] == countryItem['country'],
          orElse: () => null,
        );

        /// country에 존재하는 나라일 경우
        if (matchingCountry != null) {
          myCountries.add(matchingCountry);
          return true;

          /// 유지
        }
        return false;

        /// 제거
      });
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrailingBackAppBar(
        text: '마이 페이지',
        backTap: () {
          Get.back();
        },
        svgPicture: SvgPicture.asset(
          'assets/icon/setting.svg',
          fit: BoxFit.none,
        ),
        trailingTap: () {
          Get.to(() => SettingMainPage());
        },
        color: Colors.white,
      ),
      body: isLoading
          ? Center(child: LoadingWidget())
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  /// 프로필 사진 및 프로필
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EditProfilePage());
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
                                        child: Obx(() => ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: us.userList.isEmpty || us.userList[0].profileImg == ''
                                                  ? SettingDefaultProfileScreen(context)
                                                  : CachedNetworkImage(
                                                      imageUrl: us.userList[0].profileImg!,
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.fill,
                                                      // placeholder: (context, url) =>// const CircularProgressIndicator(),
                                                      errorWidget: (context, url, error) {
                                                        return SettingDefaultProfileScreen(context);
                                                      },
                                                    ),
                                            )),
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
                                              border: Border.all(width: 1, color: Color(0xffECECEC))),
                                          child: SvgPicture.asset('assets/icon/pencil.svg',
                                              fit: BoxFit.none,
                                              colorFilter: ColorFilter.mode(gray500, BlendMode.srcIn)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),

                              /// 닉네임
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(top: 11),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${us.userList.isEmpty ? '' : us.userList[0].nickName}',
                                            style: f20gray800w700),
                                        const SizedBox(height: 12),
                                        Text('${us.userList.isEmpty ? '' : us.userList[0].memo}')
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '다녀온 여행지',
                          style: f20gray800w700,
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        /// 국내, 해외
                        Obx(() => Row(
                              children: [
                                Text('국내 ${us.countryList.where((entry) => entry['country'] == '대한민국').length}',
                                    style: f14bluew600),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  '해외 ${us.countryList.where((entry) => entry['country'] != '대한민국').length}',
                                  style: f14redw600,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 31,
                        ),
                        Obx(() => ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0, // 원하는 maxHeight 설정
                              ),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: us.countryList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            /// 국가 이미지
                                            Container(
                                              width: 32,
                                              height: 24,
                                              decoration: BoxDecoration(border: Border.all(color: gray50, width: 1.25)),
                                              child: myCountries.isEmpty
                                                  ? const CircularProgressIndicator()
                                                  : CachedNetworkImage(
                                                      imageUrl: '${myCountries[index]['image']}',
                                                      width: 32,
                                                      height: 24,
                                                      fit: BoxFit.fill,
                                                      // placeholder: (context, url) =>
                                                      // const CircularProgressIndicator(),
                                                      errorWidget: (context, url, error) {
                                                        return const CircularProgressIndicator();
                                                      },
                                                    ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              '${us.countryList[index]['country']} (${us.countryList[index]['visitCnt']})',
                                              style: f16gray800w600,
                                            ),
                                          ],
                                        ),
                                        index != us.countryList.length - 1
                                            ? const SizedBox(
                                                height: 24,
                                              )
                                            : const SizedBox(
                                                height: 28,
                                              )
                                      ],
                                    );
                                  }),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 6,
                    color: lightGray1,
                  ),

                  /// 앱초대
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 28,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '앱 초대',
                          style: f20gray800w700,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SettingArrowRow(
                            title: '초대 링크 보내기',
                            onTap: () {
                              showCustomToast(context, fToast!, '현재 준비 중인 기능입니다.', false);
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                        Text(
                          '이용 안내',
                          style: f20gray800w700,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SettingArrowRow(
                            title: '공지사항',
                            onTap: () {
                              Get.to(() => SettingNotiMain());
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        SettingArrowRow(
                            title: 'FAQ',
                            onTap: () {
                              Get.to(() => SettingFaqMain());
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
