import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripHistory/search/search_full_map.dart';
import 'package:tripStory/screen/trip/tripHistory/search/search_history_detail.dart';
import '../../../../component/appbar.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';


class SearchHistoryList extends StatefulWidget {
  const SearchHistoryList({super.key});

  @override
  State<SearchHistoryList> createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  final hs = Get.put(HistoryState());
  final ts = Get.put(TripState());

  @override
  void initState() {
    print('>?>?? ${hs.selectedTagList}');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrailingBackAppBar(
        text: '사진 검색',
        backTap: (){Get.back();},
        svgPicture: SvgPicture.asset( 'assets/icon/map.svg',fit: BoxFit.none,),
        trailingTap: (){
          Get.to(()=>SearchFullMap());
        },
      ),
      body: Obx(()=>Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 16),
        child: Column(
          children: [
            Row(
              children: [
                hs.selectedTagList[0].containsKey('tagName')
                    ? Container(
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
                              color: Color(int.parse('0xff${hs.selectedTagList[0]['tagColor']}')), // 태그 색깔
                              shape: BoxShape.circle),
                          child: Center(
                            child: Text('#', style: f12whitew500),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('${hs.selectedTagList[0]['tagName']}', style: f12gray900w500), // 태그 이름
                      ],
                    ),
                  ),
                )
                    : Container(
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
                              imageUrl:'${hs.selectedTagList[0]['thumbnail']}',
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
                        Text('${hs.selectedTagList[0]['nickname']}', style: f12gray900w500), // 태그 이름
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16,),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0, // 열 간의 간격
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.793,
                  ),
                  itemCount: hs.searchList.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>SearchHistoryDetail(selectedIdx: hs.searchList[index]['id']));
                      },
                      child: Container(
                        width: 120,
                        child: Stack(
                          children: [
                            Positioned(
                              child: CachedNetworkImage(
                                imageUrl: '${hs.searchList[index]['thumbnail']}',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Color(0xff212121).withOpacity(0.5),
                                    ],
                                    stops: [0.54, 1],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top:12,
                              right:12,
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CachedNetworkImage(
                                  imageUrl: '${hs.searchList[index]['profileImage']}',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              left:12,
                              bottom:12,
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icon/smallheart.svg'),
                                  const SizedBox(width: 3,),
                                  Text('${hs.searchList[index]['likeCnt']}',style: f12whitew500,),
                                  const SizedBox(width: 8,),
                                  SvgPicture.asset('assets/icon/smallComment.svg'),
                                  const SizedBox(width: 3,),
                                  Text('${hs.searchList[index]['replyCnt']}',style: f12whitew500,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
              ),
            ),
          ],
        ),)),

    );
  }
}
