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
      'countries': [
        {'name': '대한민국', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/241/20220224_233513043.gif'},
      ],
    },
    {
      'region': '아시아',
      'countries': [
        {'name': '일본', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/176/20220318_162955741.gif'},
        {'name': '중국', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/182/20220329_151915812.gif'},
        {'name': '대만', 'image': 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/taiwan.png?alt=media'},
        {'name': '홍콩', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/250/20220224_233512982.gif'},
        {'name': '몽골', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/80/20220318_164338924.gif'},
        {'name': '러시아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/50/20220729_092800113.png'},
        {'name': '인도네시아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/175/20220318_162536716.gif'},
        {'name': '미얀마', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/82/20220318_164314751.gif'},
        {'name': '태국', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/214/20220318_170222070.gif'},
        {'name': '베트남', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/92/20220318_170753486.gif'},
        {'name': '말레이시아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/66/20220318_164600046.gif'},
        {'name': '필리핀', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/237/20220318_165139676.gif'},
        {'name': '라오스', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/47/20220318_163332591.gif'},
        {'name': '캄보디아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/194/20220318_163118134.jpg'},
        {'name': '싱가포르', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/133/20220318_165655208.gif'},
        {'name': '네팔', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/35/20220318_164857163.gif'},
        {'name': '몰디브', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/78/20220318_164502026.gif'},
        {'name': '방글라데시', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/88/20220318_155428211.gif'},
        {'name': '부탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/101/20220318_155946652.gif'},
        {'name': '스리랑카', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/125/20220318_163456971.gif'},
        {'name': '아프가니스탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/142/20220318_154306906.gif'},
        {'name': '이란', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/170/20220318_162755203.gif'},
        {'name': '인도', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/174/20220318_162705650.gif'},
        {'name': '파키스탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/225/20220318_165158778.gif'},
        {'name': '우즈베키스탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/167/20220318_170638365.gif'},
        {'name': '카자흐스탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/192/20220318_163310295.gif'},
        {'name': '키르기스스탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/209/20220318_163048531.gif'},
        {'name': '타지키스탄', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/212/20220318_170239649.gif'},
        {'name': '바레인', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/84/20220318_155707078.gif'},
        {'name': '사우디아라비아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/108/20220318_165528053.gif'},
        {'name': '시리아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/131/20220318_170052069.gif'},
        {'name': '아랍에미리트', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/134/20220318_154219608.gif'},
        {'name': '요르단', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/164/20220318_162932491.gif'},
        {'name': '이라크', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/169/20220318_162732536.gif'},
        {'name': '이스라엘', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/171/20220318_162634203.gif'},
        {'name': '튀르키예', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/216/20220318_170408650.gif'},
        {'name': '팔레스타인', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/228/20220318_165237143.gif'},
        {'name': '조지아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/181/20220318_161818196.gif'},
      ],
    },
    {
      'region': '유럽',
      'countries': [
        {'name': '포르투갈', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/230/20220318_165302991.gif'},
        {'name': '스페인', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/128/20220318_161418873.gif'},
        {'name': '세르비아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/115/20220318_165434935.gif'},
        {'name': '슬로베니아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/130/20220318_165717405.gif'},
        {'name': '그리스', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/24/20220720_160223089.gif'},
        {'name': '크로아티아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/208/20220318_162351871.gif'},
        {'name': '이탈리아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/173/20220318_162836837.gif'},
        {'name': '노르웨이', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/36/20220318_164831540.gif'},
        {'name': '덴마크', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/42/20220318_160957995.gif'},
        {'name': '스웨덴', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/126/20220318_165639907.gif'},
        {'name': '아이슬란드', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/138/20220318_162816057.gif'},
        {'name': '아일랜드', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/140/20220318_162604484.gif'},
        {'name': '영국', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/155/20220318_161717544.gif'},
        {'name': '핀란드', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/236/20220318_161502305.gif'},
        {'name': '불가리아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/104/20220318_155644008.gif'},
        {'name': '슬로바키아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/129/20220318_165735565.gif'},
        {'name': '우크라이나', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/168/20220729_092922428.gif'},
        {'name': '체코', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/188/20220318_160834593.gif'},
        {'name': '폴란드', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/231/20220318_165216491.png'},
        {'name': '헝가리', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/239/20220318_162505062.gif'},
        {'name': '네덜란드', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/33/20220318_164807920.gif'},
        {'name': '독일', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/45/20220318_160907982.gif'},
        {'name': '룩셈부르크', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/55/20220318_163613450.gif'},
        {'name': '모나코', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/70/20220318_163730922.gif'},
        {'name': '벨기에', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/93/20220318_155559315.gif'},
        {'name': '스위스', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/127/20220318_160311962.gif'},
        {'name': '오스트리아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/161/20220318_155125077.gif'},
        {'name': '프랑스', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/232/20220318_161621275.gif'}
      ]
    },
    {
      'region': '아메리카',
      'countries': [
        {'name': '미국', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/81/20220504_170107685.jpg'},
        {'name': '멕시코', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/69/20220318_164538562.gif'},
        {'name': '과테말라', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/21/20220318_162216873.gif'},
        {'name': '캐나다', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/195/20220318_160107913.gif'},
        {'name': '쿠바', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/205/20220318_160637411.gif'},
        {'name': '브라질', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/105/20220318_155901021.gif'},
        {'name': '수리남', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/124/20220318_165905843.gif'},
        {'name': '아르헨티나', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/137/20220318_155042415.gif'},
        {'name': '에콰도르', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/152/20220318_161233228.gif'},
        {'name': '우루과이', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/166/20220318_170622175.gif'},
        {'name': '칠레', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/189/20220318_160418259.gif'},
        {'name': '콜롬비아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/202/20220318_160540028.gif'},
        {'name': '파라과이', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/224/20220318_165336804.gif'},
        {'name': '페루', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/229/20220318_165102133.gif'},
      ],
    },
    {
      'region': '오세아니아',
      'countries': [
        {'name': '오스트레일리아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/240/20220318_155159510.gif'},
        {'name': '뉴질랜드', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/38/20220318_165002661.gif'},
      ],
    },
    {
      'region': '아프리카',
      'countries': [
        {'name': '탄자니아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/213/20220318_170507002.gif'},
        {'name': '콩고 민주 공화국', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/204/20220318_160137066.gif'},
        {'name': '가나', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/15/20220318_161935687.gif'},
        {'name': '세네갈', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/114/20220318_165832649.gif'},
        {'name': '토고', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/217/20220318_170156335.gif'},
        {'name': '알제리', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/145/20220318_161209334.gif'},
        {'name': '이집트', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/172/20220318_161328692.gif'},
        {'name': '리비아', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/57/20220318_163646072.gif'},
        {'name': '모로코', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/71/20220318_163711153.gif'},
        {'name': '튀니지', 'image': 'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/221/20220318_170333269.gif'}
      ]
    }
  ];

  /// 검색 리스트
  List<Map<String, dynamic>> filterCountries = [];
  List<Map<String, dynamic>> getFilteredCountries() {
    if (ms.tripCitySearchCon.text.isEmpty) {
      return countries;
    }
    List<Map<String, dynamic>> filteredCountries = [];
    for (var region in countries) {
      List<Map<String, dynamic>> filteredCountryList = (region['countries'] as List<Map<String, dynamic>>)
          .where((country) => country['name'].toLowerCase().contains(ms.tripCitySearchCon.text))
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
                                Container(
                                  decoration: BoxDecoration(
                                     border: Border.all(color: gray200),
                                    borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: CachedNetworkImage(
                                      imageUrl: '${filterCountries[regionIndex]['countries'][countryIndex]['image']}',
                                      width: 32,
                                      height: 24,
                                      fit: BoxFit.fill,
                                      // placeholder: (context, url) =>
                                      // const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Text(filterCountries[regionIndex]['countries'][countryIndex]['name'], style: f16gray800w500),
                              ],
                            ),
                            value: filterCountries[regionIndex]['countries'][countryIndex]['name'],
                            groupValue: ms.selectedCity.value,
                            onChanged: (String? newValue) {
                              ms.selectedCity.value = newValue!;
                              setState(() {});
                            },
                            dense: true,
                            hoverColor: gray900,
                            contentPadding: const EdgeInsets.only(left: 16, right: 16,bottom: 0),
                            controlAffinity: ListTileControlAffinity.trailing,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return gray400.withOpacity(.32);
                                  } else if (states.contains(MaterialState.selected)) {
                                    return gray900;
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
