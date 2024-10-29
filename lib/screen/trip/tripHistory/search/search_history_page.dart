import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripHistory/search/search_history_list.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  final hs = Get.put(HistoryState());
  final ts = Get.put(TripState());
  int selectedIdx = 0;
  bool isSearch = false; /// 검색했을 때
  bool isColorFilter = false; /// 컬러 클릭했을 때
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int? selectedColor;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    hs.getTagAll(ts.selectTripList[0]['id']);
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        appBar: BackAppBar(text: '사진 검색', onTap: (){Get.back();},color: Colors.white),
        body: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: gray50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: gray200,width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextIconBackFormFields(
                          controller: controller,
                          hintText: '태그, 닉네임으로 사진을 검색해보세요',
                          icon: 'assets/icon/search.svg',
                          colorFilter: ColorFilter.mode(Color(0xff5E91EE), BlendMode.srcIn),
                          hintStyle: f15gray400w500,
                          onFieldSubmitted: (value){
                            if(value.isNotEmpty){
                              isSearch = true;
                              hs.searchTagName(value);
                              setState(() {});
                            }
                          },
                      )
                    ),
                    isSearch?GestureDetector(
                      onTap: (){
                        isSearch = false;
                        controller.text = '';
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                          'assets/icon/smallXRound.svg',
                          colorFilter: ColorFilter.mode(gray900, BlendMode.srcIn)),
                    ):const SizedBox(),
                    const SizedBox(width: 16,)
                  ],
                ),
              ),
              const SizedBox(height: 24),
              /// 검색했을 때
              isSearch
                  ? Obx(()=>Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 12,
                runSpacing: 12,
                children: (hs.tagSearchList.length != 0 ? hs.tagSearchList : []).map<Widget>((info) {
                  return hs.tagSearchList[0].containsKey('tagName')
                      ? GestureDetector(
                    onTap: ()async{
                      await hs.getSelectedTag(ts.selectTripList[0]['id'], '${info['tagName']}', '${info['tagColor']}');
                      hs.selectedTagList.value = [info];
                      Get.to(()=>SearchHistoryList());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: gray200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: Color(int.parse('0xff${info['tagColor']}')), // 태그 색깔
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text('#', style: f12whitew500),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text('${info['tagName']}', style: f12gray900w500), // 태그 이름
                          ],
                        ),
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: (){
                      hs.getSelectedName(ts.selectTripList[0]['id'],info['uuid']);
                      hs.selectedTagList.value = [info];
                      Get.to(()=>SearchHistoryList());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: gray200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width:24,
                              height: 24,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: CachedNetworkImage(
                                  imageUrl:'${info['thumbnail']}',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  // placeholder: (context, url) => const CircularProgressIndicator(),
                                  // errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text('${info['nickname']}', style: f12gray900w500), // 태그 이름
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ))
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              selectedIdx = 0;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedIdx==0?gray900:gray200,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                child: Text('사진 태그',style: selectedIdx==0?f14Whitew700:f14gray400w700),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: ()async{
                              selectedIdx = 1;
                              isColorFilter = false;
                              selectedColor=null;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedIdx==1?gray900:gray200,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                child: Text('닉네임',style: selectedIdx==1?f14Whitew700:f14gray400w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      selectedIdx==0?Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 44,
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:(context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          if(selectedColor == index){
                                            isColorFilter = false;
                                            selectedColor=null;
                                          }else{
                                            isColorFilter = true;
                                            selectedColor = index;
                                            List filteredTags = hs.tagAllList.where((tag) {
                                              return tag['tagColor'] == '${colorList[index].toString().substring(8, '${colorList[index]}'.length - 1)}'.toUpperCase();
                                            }).toList();
                                            hs.tagFilterColor.value = filteredTags;
                                            hs.tagFilterColor.refresh();
                                          }
                                          setState(() {});
                                        },
                                        child: selectedColor==index
                                            ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: gray900,width: 2),
                                              color: colorList[index]
                                          ),
                                          child: SvgPicture.asset('assets/icon/checkIcon.svg',fit: BoxFit.none,),
                                        )
                                            : Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorList[index],
                                              border: colorList[index] == whiteColor?Border.all(color: gray200):null
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ):const SizedBox(),
                      isColorFilter?const SizedBox():selectedIdx==0
                          ? Obx(()=>Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 12,
                        runSpacing: 12,
                        children: (hs.tagAllList.length != 0 ? hs.tagAllList : []).map<Widget>((tag) {
                          return GestureDetector(
                            onTap: ()async{
                              hs.getSelectedTag(ts.selectTripList[0]['id'], '${tag['tagName']}', '${tag['tagColor']}');
                              hs.selectedTagList.value = [tag];
                              Get.to(()=>SearchHistoryList());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: gray200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                          color: Color(int.parse('0xff${tag['tagColor']}')), // 태그 색깔
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text('#', style: f12whitew500),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text('${tag['tagName']}', style: f12gray900w500), // 태그 이름
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ))
                          : Obx(()=>Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 12,
                        runSpacing: 12,
                        children: (ts.selectTripList[0]['tripMemberDtoList'].length != 0 ? ts.selectTripList[0]['tripMemberDtoList'] : []).map<Widget>((user) {
                          return GestureDetector(
                            onTap: (){
                              hs.getSelectedName(ts.selectTripList[0]['id'],user['uuid']);
                              hs.selectedTagList.value = [user];
                              Get.to(()=>SearchHistoryList());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: gray200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width:24,
                                      height: 24,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl:'${user['thumbnail']}',
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill
                                              ),
                                            ),
                                          ),
                                          // placeholder: (context, url) => const CircularProgressIndicator(),
                                          // errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text('${user['nickname']}', style: f12gray900w500), // 태그 이름
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                      /// 컬러 필터 용
                      selectedIdx==0&&isColorFilter?Obx(()=>Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 12,
                        runSpacing: 12,
                        children: (hs.tagFilterColor.length != 0 ? hs.tagFilterColor : []).map<Widget>((tag) {
                          return GestureDetector(
                            onTap: ()async{
                              hs.getSelectedTag(ts.selectTripList[0]['id'], '${tag['tagName']}', '${tag['tagColor']}');
                              hs.selectedTagList.value = [tag];
                              Get.to(()=>SearchHistoryList());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: gray200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                          color: Color(int.parse('0xff${tag['tagColor']}')), // 태그 색깔
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text('#', style: f12whitew500),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text('${tag['tagName']}', style: f12gray900w500), // 태그 이름
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )):const SizedBox()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
