import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/textForm.dart';
import '../../../controller/mainState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class TripSearchPage extends StatefulWidget {
  const TripSearchPage({super.key});

  @override
  State<TripSearchPage> createState() => _TripSearchPageState();
}

class _TripSearchPageState extends State<TripSearchPage> {
  final ms = Get.put(MainState());
  /// 국기 그룹 리스트
  final List<Map<String, dynamic>> countries = [
    {
      'region': '국내',
      'countries': ['대한민국'],
    },
    {
      'region': '동북아시아',
      'countries': ['일본', '중국', '대만', '홍콩', '마카오', '몽골', '러시아'],
    },
    {
      'region': '동남아시아',
      'countries': [
        '인도네시아',
        '미얀마',
        '태국',
        '베트남',
        '말레이시아',
        '필리핀',
        '라오스',
        '캄보디아',
        '싱가포르',
      ],
    },
    {
      'region': '남아시아',
      'countries': [
        '네팔',
        '몰디브',
        '방글라데시',
        '부탄',
        '스리랑카',
        '아프가니스탄',
        '이란',
        '인도',
        '파키스탄',
      ],
    },
    {
      'region': '중앙아시아',
      'countries': ['우즈베키스탄', '카자흐스탄', '키르기스스탄', '타지키스탄'],
    },
    {
      'region': '기타 아시아',
      'countries': [
        '바레인',
        '사우디아라비아',
        '시리아',
        '아랍에미리트',
        '요르단',
        '이라크',
        '이스라엘',
        '튀르키예',
        '팔레스타인',
        '조지아',
      ],
    },
    {
      'region': '유럽',
      'countries': [
        '포르투갈',
        '스페인',
        '세르비아',
        '슬로베니아',
        '그리스',
        '크로아티아',
        '이탈리아',
        '노르웨이',
        '덴마크',
        '스웨덴',
        '아이슬란드',
        '아일랜드',
        '영국',
        '핀란드',
        '불가리아',
        '슬로바키아',
        '우크라이나',
        '체코',
        '폴란드',
        '헝가리',
        '네덜란드',
        '독일',
        '룩셈부르크',
        '모나코',
        '벨기에',
        '스위스',
        '오스트리아',
        '프랑스',
      ],
    },
    {
      'region': '아메리카',
      'countries': [
        '미국',
        '멕시코',
        '과테말라',
        '캐나다',
        '쿠바',
        '브라질',
        '수리남',
        '아르헨티나',
        '에콰도르',
        '우루과이',
        '칠레',
        '콜롬비아',
        '파라과이',
        '페루',
      ],
    },
    {
      'region': '오세아니아',
      'countries': ['오스트레일리아', '뉴질랜드', '괌'],
    },
    {
      'region': '아프리카',
      'countries': [
        '탄지니아',
        '콩고 민주 공화국',
        '가나',
        '세네갈',
        '토고',
        '콩고 공화국',
        '알제리',
        '이집트',
        '리비아',
        '모로코',
        '튀니지',
      ],
    },
  ];
  /// 검색 리스트
  List<Map<String, dynamic>> filterCountries = [];
  List<Map<String, dynamic>> getFilteredCountries() {
    if (ms.tripCitySearchCon.text.isEmpty) {
      return countries;
    }
    List<Map<String, dynamic>> filteredCountries = [];
    for (var region in countries) {
      List<String> countryList = List<String>.from(region['countries']);
      List<String> filteredCountryList = countryList
          .where((country) => country.contains(ms.tripCitySearchCon.text))
          .toList();
      if (filteredCountryList.isNotEmpty) {
        filteredCountries.add({
          'region': region['region'],
          'countries': filteredCountryList,
        });
      }
    }
    return filteredCountries;
  }
  @override
  void initState() {
    filterCountries = getFilteredCountries();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextIconFormFields(
            controller: ms.tripCitySearchCon,
            hintText: '여행지를 검색해주세요',
            onChanged: (value){
              filterCountries = getFilteredCountries();
              setState(() {});
            },
            icon: 'assets/icon/search.svg'),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: filterCountries.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, regionIndex) {
              return filterCountries.length==0?Container():Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${filterCountries[regionIndex]['region']}', style: f12gray400W700),
                      ],
                    ),
                  ),
                  ...List.generate(filterCountries[regionIndex]['countries'].length, (countryIndex) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: RadioListTile<String>(
                            title: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/15/20201125_211109671.gif',
                                  width: 24,
                                  height: 24,
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                const SizedBox(width: 8),
                                Text(filterCountries[regionIndex]['countries'][countryIndex], style: f16Gray500w500),
                              ],
                            ),
                            value: filterCountries[regionIndex]['countries'][countryIndex],
                            groupValue: ms.selectedCity,
                            onChanged: (String? newValue) {
                              ms.selectedCity = newValue!;
                              setState(() {});
                            },
                            dense: true,hoverColor: Colors.red,
                            contentPadding: const EdgeInsets.only(left: 16, right: 16,bottom: 0),
                            controlAffinity: ListTileControlAffinity.trailing,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return gray400.withOpacity(.32);
                                  } else if (states.contains(MaterialState.selected)) {
                                    return Colors.red;
                                  }
                                  return gray400.withOpacity(.32);
                                }),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20,),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
