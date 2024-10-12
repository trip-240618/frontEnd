import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripStory/controller/faqState.dart';
import 'package:tripStory/screen/myPage/faq/setting_faq_detail.dart';
import '../../../component/appbar.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';
import '../notice/setting_noti_detail.dart';

class SettingFaqSearch extends StatefulWidget {
  const SettingFaqSearch({super.key});

  @override
  State<SettingFaqSearch> createState() => _SettingFaqSearchState();
}

class _SettingFaqSearchState extends State<SettingFaqSearch> {
  final fs = Get.put(FaqState());
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> searchHistoryList = [];
  bool isSearch = false;
  int selectField = 0;
  bool isTextFieldFocused = false;
  List filedList = ['전체', '자주 찾는', '여행 일정', '여행 기록'];
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await loadSearchHistory();
    });
    super.initState();
  }
  /// 검색 기록 불러오기
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
  /// 검색 기록 전체 삭제
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
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(text: '검색', onTap: () { Get.back(); }, color: Colors.white),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isSearch?Column(
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
                        onFieldSubmitted: (value)async{
                          if(value.isNotEmpty) {
                            await fs.searchFaq(value);
                            isSearch = true;
                            saveSearchHistory(value);
                            setState(() {});
                          }else{
                            isSearch = false;
                            setState(() {});
                          }
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
                          prefixIcon: GestureDetector(
                            onTap: ()async{
                              if(controller.text.isNotEmpty) {
                                await fs.searchFaq(controller.text);
                                isSearch = true;
                                saveSearchHistory(controller.text);
                                setState(() {});
                              }else{
                                isSearch = false;
                                setState(() {});
                              }
                            },
                            child: Padding(
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
                    ),
                    const SizedBox(width: 16)
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              fs.searchFaqList.isEmpty?Container(
                height: Get.height*0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icon/smallsearch.svg',width: 40,height: 40,colorFilter: ColorFilter.mode(gray200,BlendMode.srcIn)),
                    const SizedBox(height: 10,),
                    Text('검색된 정보가 없어요',style: f20gray900w700,),
                    const SizedBox(height: 10,),
                    Text('다른 키워드로 궁금하신 사항을 검색해 보세요',style: f12Gray600w400,)
                  ],
                ),
              ):Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: fs.searchFaqList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (contexts, index) {
                      return AbsorbPointer(
                        absorbing: isTextFieldFocused,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.to(() => SettingFaqDetail());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                '${fs.searchFaqList[index]['title']}',
                                style: f14Gray600w600,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text('${fs.searchFaqList[index]['type']}', style: f12gray400w500),
                              const SizedBox(height: 16),
                              Divider(
                                thickness: 1,
                                color: gray200,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ):SingleChildScrollView(
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
                          onFieldSubmitted: (value)async{
                            if(value.isNotEmpty) {
                              await fs.searchFaq(value);
                              isSearch = true;
                              saveSearchHistory(value);
                              setState(() {});
                            }else{
                              isSearch = false;
                              setState(() {});
                            }
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
                            prefixIcon: GestureDetector(
                              onTap: ()async{
                                if(controller.text.isNotEmpty) {
                                  await fs.searchFaq(controller.text);
                                  isSearch = true;
                                  saveSearchHistory(controller.text);
                                  setState(() {});
                                }else{
                                  isSearch = false;
                                  setState(() {});
                                }
                              },
                              child: Padding(
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
                      ),
                      const SizedBox(width: 16)
                    ],
                  ),
                ),
                const SizedBox(height: 46,),
                isSearch?Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 3,
                      padding: EdgeInsets.zero,
                      itemBuilder: (contexts, index) {
                        return AbsorbPointer(
                          absorbing: isTextFieldFocused,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              // Get.to(() => SettingNotiDetail());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  '[${filedList[selectField]}] 전산시스템 점검에 따른 서비스 일부 제한 안내 (8월 2일 04시 - 06시)',
                                  style: f14Gray600w600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text('2024.07.31', style: f12gray400w500),
                                const SizedBox(height: 16),
                                Divider(
                                  thickness: 1,
                                  color: gray200,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ):searchHistoryList.isEmpty?Container(
                  height: Get.height*0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icon/smallsearch.svg',width: 40,height: 40,colorFilter: ColorFilter.mode(gray200,BlendMode.srcIn)),
                      const SizedBox(height: 10,),
                      Text('아직 검색 기록이 없어요',style: f20gray900w700,),
                    ],
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
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
                                      GestureDetector(
                                        onTap: ()async{
                                          controller.text = searchHistoryList[index];
                                          await fs.searchFaq(searchHistoryList[index]);
                                          isSearch = true;
                                          saveSearchHistory(searchHistoryList[index]);
                                          setState(() {});
                                        },
                                          child: Text(searchHistoryList[index], style: f14Gray800w500,)),
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
