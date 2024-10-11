import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../component/appbar.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class SettingFaqSearch extends StatefulWidget {
  const SettingFaqSearch({super.key});

  @override
  State<SettingFaqSearch> createState() => _SettingFaqSearchState();
}

class _SettingFaqSearchState extends State<SettingFaqSearch> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> searchHistoryList = [];

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await loadSearchHistory();
      print("????? ${searchHistoryList}");
    });
    super.initState();
  }
  // 검색 기록 불러오기
  Future<void> loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistoryList = prefs.getStringList('searchHistory') ?? [];
    });
  }
  /// 검색 기록 저장
  Future<void> saveSearchHistory(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!searchHistoryList.contains(search)) {
      searchHistoryList.add(search);
      await prefs.setStringList('searchHistory', searchHistoryList);
      controller.text = '';
    }
  }
  /// 검색 기록 삭제
  Future<void> removeSearchHistory(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchHistoryList.removeAt(index);
    await prefs.setStringList('searchHistory', searchHistoryList);
    setState(() {});
  }
  // 검색 기록 전체 삭제
  Future<void> clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('searchHistory');
    setState(() {
      searchHistoryList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: BackAppBar(text: '검색', onTap: () { Get.back(); }, color: Colors.white),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 13,),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: gray50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: gray200, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          focusNode: focusNode,
                          style: f15gray800w500,
                          controller: controller,
                          onFieldSubmitted: (value) {
                            saveSearchHistory(value);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            hintText: "궁금하신 사항을 키워드로 검색해 보세요",
                            hintStyle: f15gray400w500,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: SvgPicture.asset(
                                'assets/icon/search.svg',
                                fit: BoxFit.none,
                                color: Color(0xff5E91EE),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16)
                    ],
                  ),
                ),
                const SizedBox(height: 46,),
                Row(
                  children: [
                    Text('검색 기록', style: f16gray800w700,),
                    Spacer(),
                    GestureDetector(
                      onTap: ()async{
                        await clearSearchHistory();
                      },
                        child: Text('전체 삭제', style: f12gray400W700,)),
                  ],
                ),
                searchHistoryList.isEmpty?Container():Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 16,),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchHistoryList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/smallsearch.svg'),
                                      const SizedBox(width: 10,),
                                      Text(searchHistoryList[index], style: f14Gray800w500,),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: (){
                                            removeSearchHistory(index);
                                          },
                                          child: SvgPicture.asset('assets/icon/close.svg')),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
