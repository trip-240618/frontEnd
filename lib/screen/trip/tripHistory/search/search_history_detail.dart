import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../component/empty/emptyScreen.dart';
import '../../../../controller/historyState.dart';
import '../../../../controller/tripState.dart';
import '../../../../controller/userState.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';

class SearchHistoryDetail extends StatefulWidget {
  final int historyId;
  final int pageIdx;
  const SearchHistoryDetail({super.key,required this.historyId, required this.pageIdx});

  @override
  State<SearchHistoryDetail> createState() => _SearchHistoryDetailState();
}

class _SearchHistoryDetailState extends State<SearchHistoryDetail> {
  final hs = Get.put(HistoryState());
  final ts = Get.put(TripState());
  final us = Get.put(UserState());
  TextEditingController textCon = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  PageController pageController = PageController(
    initialPage: 0,
  );/// 페이지 컨트롤러
  bool isEditing = false;
  int? editingIdx;
  FocusNode _focusNode = FocusNode();
  int selectedPageIdx = 0; /// 현재 페이지 뷰 인덱스

  @override
  void initState() {
    selectedPageIdx = widget.pageIdx;
    pageController = PageController(initialPage: selectedPageIdx);
    Future.delayed(Duration.zero,()async{

      hs.getDetailHistoryCommentList(ts.selectTripList[0]['id'], widget.historyId);
    });
    super.initState();
  }

  @override
  void dispose() {
    textCon.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>false,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          textCon.text = '';
          isEditing = false;
          setState(() {});
        },
        child: Scaffold(
          body: PageView.builder(
            controller: pageController,
            itemCount: hs.searchList.length,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (v){
              selectedPageIdx =v;
              hs.getDetailHistoryCommentList(ts.selectTripList[0]['id'], hs.searchList[v]['id']);
              setState(() {});
            },
            itemBuilder: (context , pageIdx){
              return SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Obx(()=>Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${hs.searchList[pageIdx]['imageUrl']}',
                          width: Get.width,
                          height: Get.height*0.6,
                          fit: BoxFit.fill,
                          // placeholder: (context, url) =>
                          // const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const CircularProgressIndicator(),
                        ),
                        Positioned(
                            top: 30,
                            left: 0,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                Get.back();
                                print('eqwe');
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                // color: Colors.red,
                                child: SvgPicture.asset(
                                  'assets/icon/leftArrow.svg',
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn)
                                ),
                              ),
                            )
                        ),
                        us.userList[0]['uuid']==hs.searchList[pageIdx]['writerUuid']
                            ?Positioned(
                            top: 30,
                            right: 20,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                print('dasd');
                              },
                              child: PopupMenuButton<int>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                offset: const Offset(-20, 40),
                                padding: EdgeInsets.zero,
                                menuPadding: EdgeInsets.zero,
                                shadowColor: Colors.black.withOpacity(0.4),
                                icon: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.centerRight,
                                  child: SvgPicture.asset(
                                    'assets/icon/dot.svg',
                                    height: 30,
                                    width: 20,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                                color: gray50,
                                itemBuilder: (context) => <PopupMenuEntry<int>>[
                                  PopupMenuItem<int>(
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
                                                'assets/icon/link.svg',
                                                colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                                fit: BoxFit.none,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '사진 공유',
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
                                    onTap: (){
                                      Get.back();
                                      hs.deleteHistory(ts.selectTripList[0]['id'], hs.searchList[pageIdx]['id']);
                                      hs.searchList.removeWhere((item) => item['id'] == hs.searchList[pageIdx]['id']);
                                      hs.getHistoryList(ts.selectTripList[0]['id']);
                                      hs.searchList.refresh();
                                    },
                                    padding: EdgeInsets.zero,
                                    value: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon/pencil.svg',
                                            colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '삭제하기',
                                            style: f14Gray800w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const PopupMenuDivider(height: 1),
                                  PopupMenuItem<int>(
                                    padding: EdgeInsets.zero,
                                    value: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon/siren.svg',
                                            colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '신고하기',
                                            style: f14Gray800w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )):const SizedBox(),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Color(0xff212121).withOpacity(0.5),
                                ],
                                stops: [0.3, 1],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0, // 화면의 왼쪽과 오른쪽에 닿도록 설정
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Wrap(
                              children: [
                                Text(
                                  '${hs.searchList[pageIdx]['memo']}',
                                  style: f15whitew500,
                                  maxLines: 10, // 최대 줄 수 설정
                                  overflow: TextOverflow.ellipsis, // 텍스트가 오버플로우될 경우 처리
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    hs.searchList[pageIdx]['tags'][0]==null?Container(
                      width: Get.width,
                      height: 52,
                      color: gray50,
                    ):Container(
                      width: Get.width,
                      color: gray50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 12,
                          children: hs.searchList[pageIdx]['tags'].map<Widget>((tag) {
                            return Container(
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
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text('#', style: f12whitew500),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text('${tag['tagName']}', style: f12gray900w500), // 태그 이름
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap:()async{
                                    await hs.historyListToggle(ts.selectTripList[0]['id'], hs.searchList[pageIdx]['id'],true);
                                  },
                                  child: SvgPicture.asset('assets/icon/heart.svg',colorFilter: ColorFilter.mode(hs.searchList[widget.pageIdx]['like']??false?gray900:gray300,BlendMode.srcIn))),
                              const SizedBox(width: 4),
                              Text('${hs.searchList[pageIdx]['likeCnt']}',style: f14Gray800w500,),
                              const SizedBox(width: 8),
                              SvgPicture.asset('assets/icon/chat.svg',colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)),
                              const SizedBox(width: 4),
                              Text('${hs.searchList[pageIdx]['replyCnt']}',style: f14Gray800w500,),
                            ],
                          ),
                          const SizedBox(height: 24,),
                          Obx(()=>ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: hs.historyComment.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: '${hs.historyComment[index]['profileImage']}',
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.fill,
                                          // placeholder: (context, url) =>
                                          // const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                        ),
                                      ),
                                      const SizedBox(width: 8,),
                                      Text('${hs.historyComment[index]['nickname']}'),
                                      const SizedBox(width: 6,),
                                      Text('지금'),
                                      Spacer(),
                                      us.userList[0]['uuid']==hs.historyComment[index]['writerUuid']
                                          ?PopupMenuButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          offset: const Offset(-20, 40),
                                          shadowColor: Colors.black.withOpacity(0.4),
                                          icon: Container(
                                            height: 15,
                                            width: 20,
                                            alignment: Alignment.centerRight,
                                            child: SvgPicture.asset(
                                              'assets/icon/dot.svg',
                                              height: 15,
                                              width: 20,
                                            ),
                                          ),
                                          color: gray50,
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              padding: EdgeInsets.zero,
                                              value: 1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                                                          const SizedBox(width: 10,),
                                                          Text(
                                                            '수정하기',
                                                            style: f14Gray800w500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(color: gray200,), // Divider를 Column 내의 다른 자식으로 이동
                                                ],
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  editingIdx = index;
                                                  isEditing = true;
                                                });
                                                FocusScope.of(context).requestFocus(_focusNode);
                                                textCon.text = hs.historyComment[index]['content'];
                                                // hs.editHistoryComment(ts.selectTripList[0]['id'], widget.selectedIdx, hs.historyComment[index]['id'], 'dadasdasdasda');
                                              },
                                            ),
                                            PopupMenuItem(
                                              onTap: (){
                                                hs.deleteHistoryComment(ts.selectTripList[0]['id'], hs.searchList[pageIdx]['id'], hs.historyComment[index]['id'],true);
                                                _focusNode.unfocus();
                                              },
                                              height: 0,
                                              padding: EdgeInsets.zero,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                                                          const SizedBox(width: 10,),
                                                          Text(
                                                            '삭제하기',
                                                            style: f14Gray800w500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])
                                          :const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text('${hs.historyComment[index]['content']}'),
                                  const SizedBox(height: 22),
                                ],
                              );
                            },
                          )),
                          SizedBox(height: 80),
                        ],
                      ),
                    )
                  ],
                )),
              );
            }
          ),
          bottomSheet: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding:const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: gray50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: gray200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textCon,
                        autofocus: false,
                        style: f16gray800w600,
                        onChanged: (v) {
                          setState(() {});
                        },
                        focusNode: _focusNode,
                        onFieldSubmitted: (v)async{
                          if(textCon.text.trim().isNotEmpty){
                            if(isEditing){
                              hs.editHistoryComment(ts.selectTripList[0]['id'], hs.searchList[selectedPageIdx]['id'], hs.historyComment[editingIdx!]['id'], textCon.text);
                              textCon.text='';
                              isEditing = false;
                              FocusScope.of(context).unfocus();
                            }else{
                              await hs.addHistoryComment(ts.selectTripList[0]['id'], hs.searchList[selectedPageIdx]['id'], textCon.text,true);
                              textCon.text='';
                              FocusScope.of(context).unfocus();
                              _scrollController.jumpTo(_scrollController.position.maxScrollExtent+100);
                            }
                          }
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: '댓글을 입력해주세요',
                          hintStyle: f14Gray500w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: ()async{
                        if(textCon.text.trim().isNotEmpty){
                          if(isEditing){
                            hs.editHistoryComment(ts.selectTripList[0]['id'], hs.searchList[selectedPageIdx]['id'], hs.historyComment[editingIdx!]['id'], textCon.text);
                            textCon.text='';
                            isEditing = false;
                            FocusScope.of(context).unfocus();
                          }else{
                            await hs.addHistoryComment(ts.selectTripList[0]['id'], hs.searchList[selectedPageIdx]['id'], textCon.text,true);
                            textCon.text='';
                            FocusScope.of(context).unfocus();
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent+100);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: gray900,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                          child: Text('${isEditing?'수정':'등록'}',style: f12Whitew700,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
